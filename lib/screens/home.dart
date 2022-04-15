import 'package:flutter/material.dart';
import 'package:not_netflix/components/detail.dart';
import 'package:not_netflix/components/drawer.dart';
import 'package:not_netflix/components/list_series.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  int _currentTab = 0;
  final List<Map<String, dynamic>> _tabs = [
    {
      'name': 'Home',
      'icon': const Icon(Icons.home),
      'widget': const ListSeries()
    },
    {
      'name': 'Detail',
      'icon': const Icon(Icons.list),
      // 'widget': const Detail(1)
    },
    {
      'name': 'Search',
      'icon': const Icon(Icons.search),
      'widget': const Text('TODO')
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tabs[_currentTab]['name']),
      ),
      drawer: const CustomDrawer(),
      body: _tabs[_currentTab]['widget'],
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
