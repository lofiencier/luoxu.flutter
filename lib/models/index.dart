import 'dart:convert';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import '../service/index.dart' show Api;
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Storage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    print('directory.path::${directory.path}');
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    print('path::$path/config.json');
    return File('$path/config.json');
  }

  Future<Map> readConfig() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return jsonDecode(contents);
    } catch (err) {
      return null;
    }
  }

  Future<File> writeConfig(Map config) async {
    final file = await _localFile;
    return file.writeAsString(jsonEncode(config));
  }
}

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
    try {
      var data = await Api.search(keyword);
      searchList = new Set();
      searchList.addAll(data['list']);
      notifyListeners();
    } catch (err) {
      //
    }
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
  void addToList(Map song, context, [Function callback]) {
    // TODO: implement addToList
    super.addToList(song, context);
    list.add(song);
    if (callback != null) {
      callback(list);
    }
    notifyListeners();
  }

  void dislike(song) {
    list.remove(song);
    notifyListeners();
  }

  void initStorage(List _list) {
    print('list::$_list');
    list = _list.toSet();
    notifyListeners();
  }
}

class Trial extends ListClass with ChangeNotifier {
  @override
  void addToList(Map song, context, [Function callback]) {
    // TODO: implement addToList
    super.addToList(song, context);
    final next = List.from(list);
    next.insert(0, song);
    list = next.toSet();
    if (callback != null) {
      callback(list);
    }
    notifyListeners();
  }

  void initStorage(List _list) {
    list = _list.toSet();
    notifyListeners();
  }
}

class Playing with ChangeNotifier {
  Playing({this.list});
  bool isPlaying = false;
  final Storage storage = new Storage();
  int songId;
  String mode = 'list';
  String posterUrl;
  String lyric;
  Map songInfo;
  String token;
  Map<String, String> requestHeaders;
  AssetsAudioPlayer audio;
  int tabIndex = 0;
  Set list;
  Duration position;
  Timer _debounce;

  void onSave(context) {
    final Map<String, List> config = {
      'trial': Provider.of<Trial>(context, listen: false).list.toList(),
      'favorite': Provider.of<Favorite>(context, listen: false).list.toList(),
    };
    storage.writeConfig(config);
  }

  void initStorage(context) async {
    try {
      final config = await storage.readConfig();
      Provider.of<Trial>(context, listen: false).initStorage(config['trial']);
      Provider.of<Favorite>(context, listen: false)
          .initStorage(config['favorite']);
    } catch (err) {
      print('initError::$err');
      return null;
    }
  }

  void init(String url) async {
    // audio?.dispose();
    final _audio = audio != null ? audio : AssetsAudioPlayer();
    _audio.playlistAudioFinished.listen((_) => onSongChange(_, true));
    try {
      await _audio.open(Audio.network(url));
      isPlaying = true;
      _audio.play();
      notifyListeners();
    } catch (err) {
      print('music init error::$err');
    }
    audio = _audio;
  }

  void like(context, song) {
    Provider.of<Favorite>(context, listen: false)
        .addToList(song, context, null);
  }

  void dislike(context, song) {
    Provider.of<Favorite>(context, listen: false).dislike(song);
  }

  void toggleMode() {
    if (mode == 'list') {
      mode = 'shuffle';
    } else {
      mode = 'list';
    }
    notifyListeners();
  }

  void onSongChange(_, [bool isNext = false]) {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      int index = list.toList().indexOf(songInfo);
      playSongWithIndex(index, isNext);
    });
  }

  void disposeAll(context) {
    _debounce?.cancel();
    onSave(context);
    audio?.dispose();
  }

  @override
  void playSong(song, [context, bool redirect]) async {
    if (isPlaying) {
      audio?.stop();
      isPlaying = false;
      notifyListeners();
    }
    songId = song['rid'];
    songInfo = song;
    if (redirect ?? true && context != null) {
      navigateToPlaying(context);
    }
    if (song['songUrl'] == null) {
      final data = await Api.getSongUrl(song['rid']);
      song.addAll({'songUrl': data});
      init(data);
    } else {
      init(song['songUrl']);
    }
    notifyListeners();
  }

  void navigateToPlaying(BuildContext context) =>
      Navigator.of(context).pushNamed('/playing');
  void addSongToList(Map song, BuildContext context, [bool needToPlay]) {
    print("songId:: ${song['rid']}");
    isPlaying = true;
    songId = song['rid'];
    songInfo = song;
    Provider.of<Trial>(context, listen: false)
        .addToList(song, context, (Set _list) => list = _list);
    notifyListeners();
    if (needToPlay ?? true) {
      playSong(song, context, true);
    }
    onSave(context);
  }

  void onTabChange(BuildContext context, int tab) {
    tabIndex = tab;
    final List modals = [
      Provider.of<Trial>(context, listen: false).list,
      Provider.of<Favorite>(context, listen: false).list,
    ];
    list = modals[tab];
    notifyListeners();
  }

  void togglePlaying() {
    if (isPlaying) {
      audio.pause();
    } else {
      audio.play();
    }
    isPlaying = !isPlaying;
    notifyListeners();
  }

  void rewind() {
    Duration start = -audio.currentPosition.value;
    audio?.seekBy(start);
    audio?.play();
  }

  void playSongWithIndex(int index, [bool isNext = false]) {
    final List songList = list.toList();
    final int len = songList.length;
    int indexOverride = isNext ? index + 1 : index - 1;
    if (isNext) {
      if (indexOverride >= len) {
        indexOverride = 0;
      }
    } else {
      if (indexOverride < 0) {
        indexOverride = len - 1;
      }
    }
    print('indexOverride::$indexOverride:$index');
    songInfo = songList[indexOverride];
    if (indexOverride == index) {
      rewind();
    } else {
      playSong(songInfo);
    }
  }

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
