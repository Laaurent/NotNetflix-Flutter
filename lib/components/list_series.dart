// ignore_for_file: prefer_if_null_operators

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListSeries extends StatefulWidget {
  const ListSeries({Key? key}) : super(key: key);

  @override
  State<ListSeries> createState() => _ListSeriesState();
}

class _ListSeriesState extends State<ListSeries> {
  List<dynamic> series = [];
  int _currentPage = 0;

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
    return SafeArea(
      child: Column(
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
    );
  }
}
