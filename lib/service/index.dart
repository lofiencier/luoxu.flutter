import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Api {
  static String encoded(String str) => Uri.encodeFull(str);
  static Future search(String str, {int page: 0}) => get(
      'http://search.kuwo.cn/r.s?client=kt&all=${encoded(str)}&pn=${page}&rn=10&uid=794762570&ver=kwplayer_ar_9.2.2.1&vipver=1&show_copyright_off=1&newver=1&ft=music&cluster=0&strategy=2012&encoding=utf8&rformat=json&vermerge=1&mobi=1&issubtitle=1');
  static String getPoster(String songId) =>
      'http://player.kuwo.cn/webmusic/sj/dtflagdate?flag=6&rid=MUSIC_${encoded(songId)}';
  static String getLyric(String songId) =>
      'http://mobile.kuwo.cn/mpage/html5/songinfoandlrc?mid=${encoded(songId)}&flag=0';
  static Future getSongUrl(String songId, Map headers) =>
      get('http://ts.tempmusic.tk/url/kw/${encoded(songId)}/128k', headers);
  static Future getToken() => get('http://www.kuwo.cn');

  static Future get(String url, [Map headers]) async {
    try {
      var data = await http.get(url, headers: headers);
      print('fetching data:: $url');

      return url == 'http://www.kuwo.cn'
          ? data.headers
          : convert.jsonDecode(data.body);
    } catch (err) {
      print('fetch error:: $err');
      return null;
    }
  }
}
