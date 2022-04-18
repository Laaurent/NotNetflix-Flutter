// ignore_for_file: prefer_if_null_operators

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
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
  late List<dynamic> seasons = [];
  late List<String> seasonsNumber = [];
  late String dropdownValue = 'Saison 1';
  late List<dynamic> episodes = [];
  late Future episodesPromise;

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

  // GET DATA + GET SEASONS
  Future<Map<String, dynamic>> fetchData() async {
    // -- data show
    final Uri uriShow =
        Uri.parse('https://api.tvmaze.com/shows/' + widget.id.toString());
    final responseShow = await http.get(uriShow);
    final _dataShow = jsonDecode(responseShow.body) as Map<String, dynamic>;

    //-- data seasons
    final uriSeasons = Uri.parse(
        'https://api.tvmaze.com/shows/' + widget.id.toString() + '/seasons');
    final responseSeasons = await http.get(uriSeasons);
    final _dataSeasons = jsonDecode(responseSeasons.body) as List<dynamic>;

    setState(() {
      data = _dataShow;
      image = _dataShow['image']['medium'] != null
          ? _dataShow['image']['medium']
          : _dataShow['image']['original'] != null
              ? _dataShow['image']['original']
              : 'https://www.placecage.com/640/360';

      //--
      seasons = _dataSeasons;
      for (var i = 1; i < seasons.length; i++) {
        seasonsNumber.add('Saison ' + i.toString());
      }
      dropdownValue = seasonsNumber[0];
    });

    return Future(() => data);
  }

  Future<List<dynamic>> fetchEpisodes() async {
    int seasonNum = int.parse(dropdownValue.split(' ')[1]);
    String seasonId = seasons[seasonNum - 1]['id'].toString();
    final Uri uri =
        Uri.parse('https://api.tvmaze.com/seasons/$seasonId/episodes');
    final response = await http.get(uri);
    final _data = jsonDecode(response.body) as List<dynamic>;

    setState(() {
      episodes = _data;
    });

    return Future(() => _data);
  }

  @override
  void initState() {
    super.initState();
    promise = fetchData().then((value) => {episodesPromise = fetchEpisodes()});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: promise,
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.hasData) {
            return Scaffold(
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 200,
                      child: Image.network(
                        image,
                      ),
                    ),
                    Row(
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
                                      children: [
                                        Text(
                                          data['premiered']
                                              .toString()
                                              .split('-')[0],
                                          style: const TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          seasonsNumber.length.toString() +
                                              ' saison' +
                                              (seasonsNumber.length > 1
                                                  ? 's'
                                                  : ''),
                                          style: const TextStyle(
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
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Html(data: data['summary']),
                                    ),
                                    Text(
                                        'Genre' +
                                            (data['genres'].length > 1
                                                ? 's'
                                                : ''),
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                    Text(data['genres']
                                        .map((e) => e)
                                        .join(' • ')),
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
                                            seasonsNumber.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(items),
                                          );
                                        }).toList(),
                                        onChanged: (dynamic newValue) async {
                                          setState(() {
                                            dropdownValue = newValue.toString();
                                          });
                                          await fetchEpisodes();
                                        }),
                                    FutureBuilder(
                                      future: episodesPromise,
                                      builder: ((_context, _builder) {
                                        if (_builder.hasError) {
                                          return Text(
                                              _builder.error.toString());
                                        }
                                        if (_builder.hasData) {
                                          return SizedBox(
                                            height: 256,
                                            child: ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              itemCount: episodes.length,
                                              itemBuilder: (context, index) {
                                                final episode = episodes[index];
                                                final image = episode['image']
                                                            ['medium'] !=
                                                        null
                                                    ? episode['image']['medium']
                                                    : episode['image']
                                                                ['original'] !=
                                                            null
                                                        ? episode['image']
                                                            ['original']
                                                        : 'https://www.placecage.com/640/360';
                                                return Column(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 10),
                                                      width: 256,
                                                      height: 256,
                                                      decoration: BoxDecoration(
                                                        borderRadius: const BorderRadius
                                                                .only(
                                                            topLeft: Radius
                                                                .circular(10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10)),
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              image),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(episode['name']),
                                                    Html(
                                                        data:
                                                            episode['summary']),
                                                    const Divider(
                                                      thickness: 1,
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          );
                                        }
                                        return const Text("loading");
                                      }),
                                    ),
                                    // Text(episodes.toString()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        }));
  }
}
