import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import '../service/index.dart' show Api;

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
  void playSong(id) async {
    isPlaying = true;
    songId = id;
    final data = await Api.getMusicInfo(id, requestHeaders);
    print(data);
  }

  void initToken() async {
    try {
      final headers = await Api.getToken();
      print(headers);
      print(headers['set-cookie']);
      final String cookie = headers['set-cookie'];
      final tokenString = new RegExp(r"kw_token=\w+;").stringMatch(cookie);
      final _token = tokenString.replaceAll(new RegExp(r"[(kw_token=);]"), '');
      print('token:: $token');
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
