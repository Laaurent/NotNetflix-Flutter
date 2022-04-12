import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  int _currentTab = 1;
  final List<Map<String, dynamic>> _tabs = const [
    {'name': 'Profil', 'icon': Icon(Icons.person)},
    {'name': 'Home', 'icon': Icon(Icons.home)},
    {'name': 'Search', 'icon': Icon(Icons.search)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(
        child: Text('Home'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab,
        onTap: (index) {
          setState(() {
            _currentTab = index;
          });
        },
        items: [
          ...List.generate(
              _tabs.length,
              (index) => BottomNavigationBarItem(
                  icon: _tabs[index]['icon'], label: _tabs[index]['name']))
        ],
      ),
    );
  }
}
