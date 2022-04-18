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

  Future<List<dynamic>> fetchData(page) async {
    final Uri uri =
        Uri.parse('https://api.tvmaze.com/shows?page=' + page.toString());
    final response = await http.get(uri);
    final _series = jsonDecode(response.body) as List;

    setState(() {
      series = List.from(series)..addAll(_series);
    });
    return Future(() => series);
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
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(bottom: 20),
              child: const Text(
                'Tendances actuelles',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 500,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: series.length,
                itemBuilder: (context, index) {
                  final oneSeries = series[index];
                  final image = oneSeries['image']['original'] != null
                      ? oneSeries['image']['original']
                      : oneSeries['image']['medium'] != null
                          ? oneSeries['image']['medium']
                          : 'https://www.placecage.com/640/360';
                  return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/detail',
                            arguments: {'id': oneSeries['id']});
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: 250,
                        // height: 500,
                        child: Column(
                          children: [
                            Container(
                              height: 400,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                              oneSeries['name'],
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              oneSeries['genres'].join(','),
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                            ),
                            Text(
                              oneSeries['premiered'].split('-')[0],
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        // decoration: BoxDecoration(
                        //   borderRadius:
                        //       const BorderRadius.all(Radius.circular(10)),
                        //   image: DecorationImage(
                        //     image: NetworkImage(image),
                        //     fit: BoxFit.fill,
                        //   ),
                        // ),
                      )
                      // Text(
                      //   oneSeries['name'],
                      //   style: const TextStyle(fontSize: 16),
                      // )

                      );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
