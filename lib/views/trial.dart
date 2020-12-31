import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'playlist.dart' show Playlist;
import '../models/index.dart' as models;

class Trial extends StatelessWidget {
  const Trial({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<models.Trial>(
        builder: (_, _store, child) => Playlist(
            data: _store.list,
            onDelete: _store.onDelete,
            type: 'trial',
            toggleLike: _store.toggleLike));
  }
}
