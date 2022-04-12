// ignore_for_file: prefer_if_null_operators

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  int _currentTab = 1;
  int _currentPage = 0;
  List<dynamic> series = [];
  // late Future<Series> series;
  final List<Map<String, dynamic>> _tabs = const [
    {'name': 'Profil', 'icon': Icon(Icons.person)},
    {'name': 'Home', 'icon': Icon(Icons.home)},
    {'name': 'Search', 'icon': Icon(Icons.search)},
  ];

  void fetchData(page) async {
    final Uri uri =
        Uri.parse('https://api.tvmaze.com/shows?page=' + page.toString());
    final response = await http.get(uri);
    final _series = jsonDecode(response.body) as List;

    setState(() {
      series = List.from(series)..addAll(_series);
    });
  }

  void fetchMore() {
    setState(() {
      _currentPage += 1;
    });
    fetchData(_currentPage + 1);
  }

  @override
  void initState() {
    super.initState();
    fetchData(_currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tabs[_currentTab]['name']),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Wrap(
              children: [
                const Text(
                  'Tendences actuelles',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: series.length,
                    itemBuilder: (context, index) {
                      final oneSeries = series[index];
                      final image = oneSeries['image']['medium'] != null
                          ? oneSeries['image']['medium']
                          : oneSeries['image']['original'] != null
                              ? oneSeries['image']['original']
                              : 'https://www.placecage.com/640/360';
                      return Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: 125,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          image: DecorationImage(
                            image: NetworkImage(image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => fetchMore(),
        child: const Icon(Icons.add),
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
