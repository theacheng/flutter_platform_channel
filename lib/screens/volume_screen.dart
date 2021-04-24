import 'package:flutter/material.dart';
import 'package:flutter_platform_channel/channels/volume_channel.dart';

class VolumeScreen extends StatefulWidget {
  @override
  _VolumeScreenState createState() => _VolumeScreenState();
}

class _VolumeScreenState extends State<VolumeScreen> {
  final VolumeChannel volume = VolumeChannel();
  double? currentVolume;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: volume.maxVolume,
        builder: (context, AsyncSnapshot<int> snapshot) {
          return FutureBuilder(
            future: volume.currentVolume,
            builder: (context, AsyncSnapshot<int> childSnapshot) {
              double? _currentVolume =
                  currentVolume ?? childSnapshot.data?.toDouble();
              return Slider(
                min: 0,
                value: _currentVolume ?? 1.0,
                max: snapshot.data?.toDouble() ?? 1.0,
                onChanged: (double value) async {
                  setState(() => currentVolume = value);
                  await volume.setVolumeLevel(value.toInt());
                },
              );
            },
          );
        },
      ),
    );
  }
}
