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
    searchList.addAll(data['abslist']);
    notifyListeners();
  }
}

class Playlist extends ChangeNotifier {}

class Playing extends ChangeNotifier {
  bool isPlaying = false;
  String songId;
  String posterUrl;
  String lyric;
  Map songInfo;
  String token;
  Map<String, String> requestHeaders;
  @override
  void playSong(id, context) async {
    isPlaying = true;
    songId = id;
    // final data = await Api.getSongUrl(id, requestHeaders);
    // print(data);
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
