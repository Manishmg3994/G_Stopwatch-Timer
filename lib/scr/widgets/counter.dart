import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({super.key});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  int initialDuration = 300; // Initial duration in seconds (5 minutes)
  int currentDuration = 300; // Current duration in seconds
  bool isRunning = false;

  @override
  Widget build(BuildContext context) {
    String formattedTime = _formattedTime(currentDuration);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              formattedTime,
              style: TextStyle(fontSize: 48),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isRunning
                    ? ElevatedButton(
                        onPressed: _pauseTimer,
                        child: Text("Pause"),
                      )
                    : ElevatedButton(
                        onPressed: _startTimer,
                        child: Text("Start"),
                      ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _resetTimer,
                  child: Text("Reset"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _startTimer() {
    setState(() {
      isRunning = true;
    });
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (isRunning) {
        if (currentDuration > 0) {
          setState(() {
            currentDuration--;
          });
        } else {
          _stopTimer();
          _vibrate(); // Trigger haptic feedback
        }
      } else {
        timer.cancel();
      }
    });
  }

  void _pauseTimer() {
    setState(() {
      isRunning = false;
    });
  }

  void _stopTimer() {
    setState(() {
      isRunning = false;
    });
  }

  void _resetTimer() {
    setState(() {
      currentDuration = initialDuration;
      isRunning = false;
    });
  }

  String _formattedTime(int seconds) {
    int minutes = (seconds / 60).floor();
    int remainingSeconds = seconds % 60;

    return "$minutes:${_twoDigits(remainingSeconds)}";
  }

  String _twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  void _vibrate() {
    HapticFeedback.heavyImpact();
    // if (Vibration.hasVibrator()) {
    //   Vibration.vibrate();
    // }
  }
}
