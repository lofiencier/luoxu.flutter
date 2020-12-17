import 'package:flutter/material.dart';
import 'playlist.dart' show Playlist;

class Favorite extends StatelessWidget {
  const Favorite({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Playlist(
        data: new List<Map>.filled(20, {'title': '1', 'subTitle': '2'}));
  }
}
