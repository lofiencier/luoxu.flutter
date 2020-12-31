import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'playlist.dart' show Playlist;
import '../models/index.dart' as models;

class Favorite extends StatelessWidget {
  const Favorite({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<models.Favorite>(
        builder: (_, _store, child) =>
            Playlist(data: _store.list, type: 'favorite'));
  }
}
