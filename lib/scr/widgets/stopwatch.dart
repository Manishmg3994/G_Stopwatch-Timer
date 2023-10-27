

class _StopwatchTimerState extends State<StopwatchTimer> {
  bool isRunning = false;
  int totalMilliseconds = 0;

  @override
  Widget build(BuildContext context) {
    // Wrap your content in PageStorage
    return PageStorage(
      bucket: PageStorageBucket(),
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "${_formattedTime(totalMilliseconds)}",
                style: TextStyle(fontSize: 48),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isRunning = !isRunning;
                        if (isRunning) {
                          _startTimer();
                        } else {
                          _stopTimer();
                        }
                      });
                    },
                    child: Text(isRunning ? "Pause" : "Start"),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _resetTimer();
                      });
                    },
                    child: Text("Reset"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _startTimer() {
    Timer.periodic(Duration(milliseconds: 10), (Timer timer) {
      if (isRunning) {
        totalMilliseconds += 10;
        if (mounted) {
          setState(() {});
        }
      } else {
        timer.cancel();
      }
    });
  }

  void _stopTimer() {
    isRunning = false;
  }

  void _resetTimer() {
    isRunning = false;
    setState(() {
      totalMilliseconds = 0;
    });
  }

  String _formattedTime(int milliseconds) {
    int seconds = (milliseconds ~/ 1000) % 60;
    int minutes = (milliseconds ~/ (1000 * 60)) % 60;
    int hours = (milliseconds ~/ (1000 * 60 * 60));
    int remainingMilliseconds = milliseconds % 1000;

    return "${_twoDigits(hours)}ₕ${_twoDigits(minutes)}ₘ${_twoDigits(seconds)}ₛ${_threeDigits((remainingMilliseconds)).substring(0, 2)}ₘₛ";
  }

  String _twoDigits(int n) {
    if (n >= 10) {
      return "$n";
    }
    return "0$n";
  }

  String _threeDigits(int n) {
    if (n >= 100) {
      return "$n";
    } else if (n >= 10) {
      return "0$n";
    }
    return "00$n";
  }
}