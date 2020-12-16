String encoded(String str) => Uri.encodeFull(str);
String search(String str) =>
    'http://search.kuwo.cn/r.s?client=kt&all=${encoded(str)}&pn=0&rn=10&uid=794762570&ver=kwplayer_ar_9.2.2.1&vipver=1&show_copyright_off=1&newver=1&ft=music&cluster=0&strategy=2012&encoding=utf8&rformat=json&vermerge=1&mobi=1&issubtitle=1';
String getPoster(String songId) =>
    'http://player.kuwo.cn/webmusic/sj/dtflagdate?flag=6&rid=MUSIC_${encoded(songId)}';
String getLyric(String songId) =>
    'http://mobile.kuwo.cn/mpage/html5/songinfoandlrc?mid=${encoded(songId)}&flag=0';
String getMusicInfo(String songId) =>
    'http://www.kuwo.cn/api/www/music/musicInfo?mid=${encoded(songId)}';
String getToken() => 'http://www.kuwo.cn';
