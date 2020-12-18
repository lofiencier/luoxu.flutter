import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/index.dart' as models;

class ControlBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<models.Playing>(builder: (_, _store, child) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(40, 40, 40, 80),
        child: Column(
          children: <Widget>[
            LinearProgressIndicator(
              value: .1,
              valueColor: AlwaysStoppedAnimation(Colors.red),
              backgroundColor: Colors.grey,
            ),
            ControlBarButtons(),
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
      return Padding(
        padding: EdgeInsets.only(top: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.shuffle),
            Icon(Icons.fast_rewind),
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
            Icon(Icons.fast_forward),
            Icon(Icons.file_download)
          ],
        ),
      );
    });
  }
}
