import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';

class ProcessBar extends StatefulWidget {
  bool playing;
  Duration duration;
  AssetsAudioPlayer audio;
  Duration position;
  ProcessBar({Key key, this.playing, this.audio, this.duration, this.position})
      : super(key: key);

  @override
  _ProcessBarState createState() => _ProcessBarState();
}

class _ProcessBarState extends State<ProcessBar> {
  Timer ticker;
  double percent = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  void didUpdateWidget(covariant ProcessBar oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    // if (widget.duration ?? true) {
    //   init();
    // }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ticker.cancel();
  }

  void init() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      final double process =
          widget.audio?.currentPosition.value?.inMilliseconds /
              widget.audio?.current.value.audio.duration?.inMilliseconds;
      setState(() {
        percent = process;
      });
      ticker = timer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LinearProgressIndicator(
        value: percent,
        valueColor: AlwaysStoppedAnimation(Colors.red),
        backgroundColor: Colors.grey,
      ),
    );
  }
}
