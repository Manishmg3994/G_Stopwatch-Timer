import 'package:flutter/material.dart';

void main() => runApp(const MyApp());
final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor:
        Colors.white.withOpacity(0.9), // White with opacity
    // Define other light theme properties here
    tabBarTheme: TabBarTheme(indicatorColor: Color.fromRGBO(94, 166, 235, 1)));

final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor:
        const Color.fromARGB(255, 32, 33, 36), // Brown background
    // Define other dark theme properties here
    tabBarTheme: TabBarTheme(indicatorColor: Color.fromRGBO(94, 166, 235, 1)));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system, // Set theme mode to follow system
      theme: lightTheme,
      darkTheme: darkTheme,
      home: HomePageScreen(),
    );
  }
}

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _currentIndex = _tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basic Project'),
        bottom: TabBar(
          indicatorColor: Color.fromRGBO(94, 166, 235, 1),
          controller: _tabController,
          tabs: [
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.hourglass_empty,
                    color: _currentIndex == 0
                        ? Color.fromRGBO(94, 166, 235, 1)
                        : null,
                  ), // Icon for Tab 1
                  Text(
                    'TIMER',
                    style: TextStyle(
                        color: _currentIndex == 0
                            ? Color.fromRGBO(94, 166, 235, 1)
                            : null),
                  ),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.timer,
                    color: _currentIndex == 1
                        ? Color.fromRGBO(94, 166, 235, 1)
                        : null,
                  ), // Icon for Tab 2
                  Text(
                    'STOPWATCH',
                    style: TextStyle(
                        color: _currentIndex == 1
                            ? Color.fromRGBO(94, 166, 235, 1)
                            : null),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index:
            _currentIndex, //_tabController.index, // Use the index from TabController
        children: [
          // Content for Tab 1
          CountdownTimer(),
          // Content for Tab 2
          StopwatchTimer()
        ],
      ),
    );
  }
}
