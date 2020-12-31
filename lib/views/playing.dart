import 'package:flutter/material.dart';
import 'spin.dart' show Spin;
import 'package:provider/provider.dart';
import 'controlBar.dart' show ControlBar;
import '../models/index.dart' as models;

class Playing extends StatelessWidget {
  const Playing({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<models.Playing>(builder: (_, _store, child) {
      return Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 40),
                child: ClipOval(
                  child: Container(
                    padding: EdgeInsets.all(40),
                    color: Colors.black,
                    child: Spin(
                        spinning: _store.isPlaying,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(_store.songInfo['pic']),
                          backgroundColor: Colors.brown.shade800,
                          radius: 120,
                          child: _store.isPlaying
                              ? null
                              : Icon(
                                  Icons.play_circle_filled,
                                  size: 70,
                                  color: Colors.white,
                                ),
                          foregroundColor: Colors.black,
                        )),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
              ),
              Text(
                _store.songInfo['name'],
                style: TextStyle(fontSize: 20),
              ),
              Text(
                _store.songInfo['artist'],
                style: TextStyle(color: Colors.grey),
              ),
              Text('10/21', style: TextStyle(color: Colors.grey)),
              ControlBar()
            ],
          ),
        ),
      );
    });
  }
}
