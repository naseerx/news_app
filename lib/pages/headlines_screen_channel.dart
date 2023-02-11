import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../api_key.dart';
import '../models/headline_model.dart';
import 'Explanation_screen.dart';
import 'constant.dart';

class HeadlinesScreen extends StatefulWidget {
  final String tag;
  final String name;
  final String image;
  const HeadlinesScreen(
      {Key? key, required this.tag, required this.name, required this.image})
      : super(key: key);

  @override
  State<HeadlinesScreen> createState() => _HeadlinesScreenState();
}

class _HeadlinesScreenState extends State<HeadlinesScreen> {
  late StreamController _streamController;
  late Stream stream;
  String token = apiKey;

  var dateFormat = DateFormat('dd MM yy h:mm: aa');


  //            *************************************   API   ******************************
//method of calling api from server
  getProfileApi() async {
    String tag = widget.tag;
    try {
      _streamController.add('loading');
      String url =
          'https://api.newscatcherapi.com/v2/latest_headlines?lang=en,ur&sources=$tag';
      var response =
          await http.get(Uri.parse(url), headers: {'X-API-KEY': token});
      if (response.statusCode == 200) {
        var dataJson = json.decode(response.body);
        NewsHeadlinesModel getProfileModel =
            NewsHeadlinesModel.fromJson(dataJson);
        _streamController.add(getProfileModel);
        print(dataJson);
      } else {
        _streamController.add('No data');
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print('====================================> $e');
      }
    }
  }

  //            *************************************   API   ******************************


  @override
  void initState() {
    super.initState();
    _streamController = StreamController();
    stream = _streamController.stream.asBroadcastStream();
    getProfileApi();
    if (kDebugMode) {
      print(widget.tag);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NEWS SOURCE'),
        centerTitle: true,
        toolbarHeight: 80,
      ),
      body: StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == 'loading') {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              NewsHeadlinesModel model = snapshot.data;
              return ListView.builder(
                  itemCount: model.articles.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var data = model.articles[index];
                    return Padding(
                      padding: const EdgeInsets.all(2),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ExplanationScreen(
                                  tag: widget.tag,
                                  name: widget.name,
                                  image: widget.image,
                                  data: data,
                                ),
                              ));
                        },
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: const BorderSide(
                                width: 4,
                                color: Colors.white,
                              )),
                          color: Kcolor,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image(
                                        image: NetworkImage(data.media),
                                        width: 100,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    CircleAvatar(
                                      backgroundImage: AssetImage(widget.image),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.name,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          dateFormat.format(data.publishedDate),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  data.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }
          } else {
            return const Center(child: Text('No data'));
          }
        },
      ),
    );

  }
}
