// ignore_for_file: prefer_if_null_operators

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late String term;
  final key = GlobalKey<FormState>();
  late dynamic data;
  late String image;
  late Future promise;

  void getData() async {
    Uri uri = Uri.parse('https://api.tvmaze.com/search/shows?q=$term');
    final _show = await http.get(uri);
    final _data = jsonDecode(_show.body) as List<dynamic>;

    // dynamic _dataAsMap = _data.map((e) => e.show);
    setState(() {
      data = _data;
      promise = Future(() => _data);
    });
  }

  @override
  void initState() {
    super.initState();
    promise = Future.value(null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: key,
          child: Column(
            children: [
              TextFormField(
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (String? value) {
                  setState(() {
                    term = value!;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Search',
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (key.currentState!.validate()) {
                    key.currentState!.save();
                    getData();
                  }
                },
                child: const Text('Search'),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        resultList(),
      ],
    );
  }

  FutureBuilder<dynamic> resultList() {
    return FutureBuilder(
      future: promise,
      builder: ((_context, _builder) {
        if (_builder.hasError) {
          return Text(_builder.error.toString());
        }
        if (_builder.hasData) {
          return SizedBox(
              height: 500,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _builder.data.length,
                  itemBuilder: (context, index) {
                    final oneSeries = _builder.data[index]['show'];
                    late String image;
                    if (oneSeries['image'] == null) {
                      image = 'https://www.placecage.com/640/360';
                    } else {
                      if (oneSeries['image']['original'] != null) {
                        image = oneSeries['image']['original'];
                      } else if (oneSeries['image']['medium'] != null) {
                        image = oneSeries['image']['medium'];
                      } else {
                        image = 'https://www.placecage.com/640/360';
                      }
                    }
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
                              SizedBox(
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
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                oneSeries['premiered'] != null
                                    ? oneSeries['premiered'].split('-')[0]
                                    : '',
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ));
                  }));
        }
        return const Text('no data');
      }),
    );
  }
}
