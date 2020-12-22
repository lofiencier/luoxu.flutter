import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import '../service/index.dart' show Api;
import 'package:flutter/material.dart';

class Searching with ChangeNotifier {
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
  Provider playing;

  void addToList(Map song, context) {
    // Navigator.of(context).pushNamed('/');
  }
}

class Favorite extends ListClass with ChangeNotifier {
  @override
  void addToList(Map song, context) {
    // TODO: implement addToList
    super.addToList(song, context);
    list.add(song);
    notifyListeners();
  }
}

class Trial extends ListClass with ChangeNotifier {
  @override
  void addToList(Map song, context) {
    // TODO: implement addToList
    super.addToList(song, context);
    final next = List.from(list);
    next.insert(0, song);
    list = next.toSet();
    notifyListeners();
  }
}

class Playing with ChangeNotifier {
  bool isPlaying = false;
  int songId;
  String posterUrl;
  String lyric;
  Map songInfo;
  String token;
  Map<String, String> requestHeaders;
  Audio audio;

  void init(String url) async {
    final _audio = AssetsAudioPlayer();
    try {
      await _audio.open(Audio.network(url));
    } catch (err) {
      print('music init error::$err');
    }
  }

  @override
  void playSong(song, context, [bool redirect]) async {
    isPlaying = true;
    songId = song['rid'];
    songInfo = song;
    if (redirect ?? true) {
      navigateToPlaying(context);
    }
    final data = await song['songUrl'] != null
        ? song['songUrl']
        : Api.getSongUrl(song['rid']);
    song.addAll({'songUrl': data});
    init(data);
    notifyListeners();
  }

  void navigateToPlaying(BuildContext context) =>
      Navigator.of(context).pushNamed('/playing');
  void addSongToList(Map song, BuildContext context, [bool needToPlay]) {
    print("songId:: ${song['rid']}");
    isPlaying = true;
    songId = song['rid'];
    songInfo = song;
    Provider.of<Trial>(context, listen: false).addToList(song, context);
    notifyListeners();
    if (needToPlay ?? true) {
      playSong(song, context, true);
    }
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
