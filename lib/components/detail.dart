// ignore_for_file: prefer_if_null_operators

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Detail extends StatefulWidget {
  final int id;
  const Detail({Key? key, required this.id}) : super(key: key);
  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  // data from json
  late Future promise;
  late Map<String, dynamic> data;
  late String image;

  String dropdownValue = 'Saison 1';
  var itemsDropdown = ['Saison 1', 'Saison 2', 'Saison 3', 'Saison 4'];
  List<String> list = [
    'https://images.unsplash.com/photo-1647436929276-43fa809c907c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=930&q=80',
    'https://images.unsplash.com/photo-1579656592043-a20e25a4aa4b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1974&q=80',
    'https://images.unsplash.com/photo-1647436929276-43fa809c907c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=930&q=80',
    'https://images.unsplash.com/photo-1647436929276-43fa809c907c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=930&q=80',
    'https://images.unsplash.com/photo-1647436929276-43fa809c907c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=930&q=80',
    'https://images.unsplash.com/photo-1647436929276-43fa809c907c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=930&q=80',
    'https://images.unsplash.com/photo-1647436929276-43fa809c907c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=930&q=80',
    'https://images.unsplash.com/photo-1647436929276-43fa809c907c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=930&q=80',
    'https://images.unsplash.com/photo-1647436929276-43fa809c907c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=930&q=80',
    'https://images.unsplash.com/photo-1647436929276-43fa809c907c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=930&q=80',
    'https://images.unsplash.com/photo-1647436929276-43fa809c907c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=930&q=80',
    'https://images.unsplash.com/photo-1647436929276-43fa809c907c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=930&q=80',
  ];

  Future<Map<String, dynamic>> fetchData() async {
    final Uri uri =
        Uri.parse('https://api.tvmaze.com/shows/' + widget.id.toString());
    final response = await http.get(uri);
    final _data = jsonDecode(response.body) as Map<String, dynamic>;

    setState(() {
      data = _data;
      image = _data['image']['medium'] != null
          ? _data['image']['medium']
          : _data['image']['original'] != null
              ? _data['image']['original']
              : 'https://www.placecage.com/640/360';
    });
    return Future(() => data);
  }

  @override
  void initState() {
    super.initState();
    promise = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: promise,
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return const Text('has error');
          }
          if (snapshot.hasData) {
            return Scaffold(
              body: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 200,
                    child: Image.network(
                      image,
                    ),
                  ),
                  SingleChildScrollView(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['name'],
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Wrap(
                                      spacing: 10,
                                      children: const [
                                        Text(
                                          '2019',
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          '13+',
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          '6 saisons',
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.grey,
                                          padding: const EdgeInsets.all(16.0),
                                          primary: Colors.white,
                                          textStyle:
                                              const TextStyle(fontSize: 20),
                                        ),
                                        onPressed: () {},
                                        child: const Text('Lecture'),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.grey,
                                          padding: const EdgeInsets.all(16.0),
                                          primary: Colors.white,
                                          textStyle:
                                              const TextStyle(fontSize: 20),
                                        ),
                                        onPressed: () {},
                                        child: const Text('Télécharger'),
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child: Text(
                                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      'Avec : Cilian Murphy',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    const Text(
                                      'Créateur : Steven knight',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Center(
                                        child: Wrap(
                                          spacing: 50,
                                          children: [
                                            Column(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      print('Pressed');
                                                    },
                                                    icon:
                                                        const Icon(Icons.done)),
                                                const Text(
                                                  'Ma liste',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      print('Pressed');
                                                    },
                                                    icon: const Icon(Icons
                                                        .thumb_up_alt_outlined)),
                                                const Text(
                                                  'Evaluer',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      print('Pressed');
                                                    },
                                                    icon: const Icon(
                                                        Icons.share)),
                                                const Text(
                                                  'Partager',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      print('Pressed');
                                                    },
                                                    icon: const Icon(
                                                        Icons.download)),
                                                const Text(
                                                  'Télécharger',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      'Episodes',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    DropdownButton(
                                        value: dropdownValue,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        items:
                                            itemsDropdown.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(items),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownValue = newValue!;
                                          });
                                        })
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        }));
  }
}
