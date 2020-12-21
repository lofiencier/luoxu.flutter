import 'dart:async';

import 'dart:math';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Api {
  static String encoded(String str) => Uri.encodeFull(str);
  static Future search(String key, {int page: 0, int rn: 30}) => get(
      'http://www.kuwo.cn/api/www/search/searchMusicBykeyWord?pn=${page}&rn=${rn}&key=${encoded(key)}',
      {'Referer': 'http://www.kuwo.cn/search/list?key=${encoded(key)}'});
  static String getPoster(String songId) =>
      'http://player.kuwo.cn/webmusic/sj/dtflagdate?flag=6&rid=MUSIC_${encoded(songId)}';
  static String getLyric(String songId) =>
      'http://mobile.kuwo.cn/mpage/html5/songinfoandlrc?mid=${encoded(songId)}&flag=0';
  static Future getSongUrl(int songId) => get(
      'http://www.kuwo.cn/url?&rid=${songId}&response=url&type=convert_url3&br=128kmp3&from=web&t=${new DateTime.now()}');
  static Future getToken() => get('http://www.kuwo.cn');

  static Future get(String url, [Map<String, String> header]) async {
    Map<String, String> headers = {
      'Cookie':
          '_ga=GA1.2.439463486.1581053783; _gid=GA1.2.460728407.1581575374; _gat=1; Hm_lvt_cdb524f42f0ce19b169a8071123a4797=1581345008,1581389305,1581575375,1581599987;Hm_lpvt_cdb524f42f0ce19b169a8071123a4797=1581599987;kw_token=EF8GFA14OTW',
      'csrf': 'EF8GFA14OTW',
      'Host': 'www.kuwo.cn',
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36'
    };
    if (header != null) {
      headers.addAll(header);
    }
    try {
      var request = http.get(url, headers: headers);
      var data = await request;
      print('fetching data:: $url');
      print('request:: $request');
      print('data fetched:: ${data.body}');
      var body = convert.jsonDecode(data.body);
      if (body['code'] == 200) {
        return body['data'] ?? body['url'];
      } else {
        // return new Completer().completeError(null);
        return null;
      }
    } catch (err) {
      print('fetch error:: $err');
      return null;
    }
  }
}
