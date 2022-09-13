import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ncs_io/ncs_io.dart';

class PlayerScreen extends StatefulWidget {
  final Song song;

  const PlayerScreen({Key? key, required this.song}) : super(key: key);

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      playAudio();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [IconButton(onPressed: playAudio, icon: const Icon(Icons.play_arrow))]),
      body: Text(widget.song.songUrl ?? ''),
    );
  }

  playAudio() async {
    await player.setUrl(widget.song.songUrl ?? '');
    await player.play();
    // await player.pause();
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }
}
