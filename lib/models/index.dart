import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import '../service/index.dart' show Api;
import 'package:flutter/material.dart';

class Searching extends ChangeNotifier {
  Set searchList = new Set();
  String query = '';
  void setSearchList() {
    return null;
  }

  void setQuery(String str) {
    query = str;
    notifyListeners();
  }

  void onSubmit(String keyword) {
    print('on submit :${keyword}');
    _search(keyword);
  }

  void _search(keyword) async {
    var data = await Api.search(keyword);
    searchList = new Set();
    searchList.addAll(data['list']);
    notifyListeners();
  }
}

abstract class ListClass {
  Set list = new Set();
  void addToList(Map song, context) {
    Navigator.of(context).pushNamed('/playing');
  }
}

class Playlist extends ChangeNotifier with ListClass {
  @override
  void addToList(Map song, context) {
    // TODO: implement addToList
    super.addToList(song, context);
    list.add(song);
    notifyListeners();
  }
}

class Playing extends ChangeNotifier {
  bool isPlaying = false;
  int songId;
  String posterUrl;
  String lyric;
  Map songInfo;
  String token;
  Map<String, String> requestHeaders;
  @override
  void playSong(Map song, context) async {
    isPlaying = true;
    songId = song['id'];
    final data = await Api.getSongUrl(songId);
    song.addAll({'songUrl': data});
    songInfo = song;
    print('playsong:: $data');
    Navigator.of(context).pushNamed('/playing');
    notifyListeners();
  }

  void togglePlaying() {
    isPlaying = !isPlaying;
    notifyListeners();
  }

  void playSongWithIndex() {}

  void initToken() async {
    try {
      final headers = await Api.getToken();
      print(headers);
      print(headers['set-cookie']);
      final String cookie = headers['set-cookie'];
      final tokenString = new RegExp(r"kw_token=\w+;").stringMatch(cookie);
      final _token = tokenString.replaceAll(new RegExp(r"[(kw_token=);]"), '');
      print('token:: $_token');
      token = _token;
      requestHeaders = {
        'Referer': 'http://www.kuwo.cn/',
        'csrf': token,
        'cookie': 'kw_token=$token',
      };

      notifyListeners();
    } catch (err) {
      print('get token error:: $err');
    }
  }
}
