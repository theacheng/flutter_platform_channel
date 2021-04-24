import 'package:flutter/material.dart';
import 'package:flutter_platform_channel/channels/bettery_lavel.dart';

class BetteryScreen extends StatefulWidget {
  @override
  _BetteryScreenState createState() => _BetteryScreenState();
}

class _BetteryScreenState extends State<BetteryScreen> {
  int? betteryLevel;
  @override
  Widget build(BuildContext context) {
    BetterLevel betterLevel = BetterLevel();
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text("Get bettery $betteryLevel"),
          onPressed: () async {
            int? value = await betterLevel.getBatteryLevel();
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
