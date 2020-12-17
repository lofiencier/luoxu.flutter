import 'package:flutter/material.dart';

class ControlBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
  }
}

class ControlBarButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.shuffle),
          Icon(Icons.fast_rewind),
          Icon(
            Icons.play_circle_filled,
            size: 50,
            color: Colors.red,
          ),
          Icon(Icons.fast_forward),
          Icon(Icons.file_download)
        ],
      ),
    );
  }
}
