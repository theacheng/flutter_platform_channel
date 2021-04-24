import 'package:flutter/material.dart';
import 'package:flutter_platform_channel/screens/bettery_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text("Bettery"),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return BetteryScreen();
            }));
          },
        ),
      ),
    );
  }
}
