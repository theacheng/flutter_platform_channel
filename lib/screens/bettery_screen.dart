import 'package:flutter/material.dart';
import 'package:flutter_platform_channel/channels/bettery_channel.dart';

class BetteryScreen extends StatefulWidget {
  @override
  _BetteryScreenState createState() => _BetteryScreenState();
}

class _BetteryScreenState extends State<BetteryScreen> {
  final BetteryChannel bettery = BetteryChannel();
  int? betteryLevel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text("Get bettery ${betteryLevel ?? bettery.errorMessage}"),
          onPressed: () async {
            int? value = await bettery.getBatteryLevel();
            if (value != null) {
              setState(() {
                betteryLevel = value;
              });
            }
          },
        ),
      ),
    );
  }
}
