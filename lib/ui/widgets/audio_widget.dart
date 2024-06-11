import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String url;
  AudioPlayerWidget({required this.url});

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _loadAudio();
  }

  Future<void> _loadAudio() async {
    try {
      await _audioPlayer.setUrl(widget.url);
      _audioPlayer.play();
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SliderTheme(
          data: SliderThemeData(
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
          ),
          child: StreamBuilder<Duration>(
            stream: _audioPlayer.positionStream,
            builder: (context, snapshot) {
              final duration = snapshot.data ?? Duration.zero;
              return Slider(
                value: duration.inSeconds.toDouble(),
                min: 0,
                max: _audioPlayer.duration?.inSeconds.toDouble() ?? 1,
                onChanged: (value) {
                  _audioPlayer.seek(Duration(seconds: value.toInt()));
                },
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.play_arrow),
              onPressed: () {
                _audioPlayer.play();
              },
            ),
            IconButton(
              icon: Icon(Icons.pause),
              onPressed: () {
                _audioPlayer.pause();
              },
            ),
            IconButton(
              icon: Icon(Icons.stop),
              onPressed: () {
                _audioPlayer.stop();
              },
            ),
          ],
        )
      ],
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
