import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/index.dart' as models;
import 'ticker.dart' show ProcessBar;

class ControlBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<models.Playing>(builder: (_, _store, child) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(40, 40, 40, 80),
        child: Column(
          children: <Widget>[
            ProcessBar(
              audio: _store.audio,
            ),
            ControlBarButtons(),
            IconButton(
                icon: Icon(Icons.save), onPressed: () => _store.onSave(context))
          ],
        ),
      );
    });
  }
}

class ControlBarButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<models.Playing>(builder: (_, _store, child) {
      final bool isFavorite =
          Provider.of<models.Favorite>(context).list?.contains(_store.songInfo);
      return Padding(
        padding: EdgeInsets.only(top: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: isFavorite
                    ? Icon(Icons.favorite, color: Colors.red)
                    : Icon(Icons.favorite_outline),
                onPressed: () => isFavorite
                    ? _store.dislike(context, _store.songInfo)
                    : _store.like(context, _store.songInfo)),
            IconButton(
                icon: Icon(Icons.fast_rewind),
                onPressed: () => _store.onSongChange(_, false)),
            IconButton(
              icon: Icon(
                _store.isPlaying
                    ? Icons.pause_circle_filled_outlined
                    : Icons.play_circle_filled,
                color: Colors.red,
              ),
              iconSize: 50,
              onPressed: _store.togglePlaying,
            ),
            IconButton(
                icon: Icon(Icons.fast_forward),
                onPressed: () => _store.onSongChange(null, true)),
            IconButton(
                icon: Icon(_store.mode == 'list'
                    ? Icons.cached_outlined
                    : Icons.shuffle),
                onPressed: _store.toggleMode),
          ],
        ),
      );
    });
  }
}
