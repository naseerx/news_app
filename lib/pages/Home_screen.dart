import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../api_key.dart';
import '../models/headline_model.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late StreamController _streamController;
  late Stream stream;
  String token = apiKey;

  var dateFormat = DateFormat('dd MM yy h:mm: a');


  //            *************************************   API   ******************************
//method of calling api from server
  getProfileApi() async {
    try {
      _streamController.add('loading');
      String url =
          'https://api.newscatcherapi.com/v2/latest_headlines?lang=en,ur';
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
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Final Year News App"),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.logout_outlined),
              onPressed: () {},
            ),
          ],
          backgroundColor: const Color.fromARGB(255, 184, 0, 0),
        ),
        body: ListView.builder(
            itemCount: 50,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(3),
                child: InkWell(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => const ExplanationScreen(),
                    //     ));
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          width: 3,
                          color: Colors.white,
                        )),
                    color: Color.fromARGB(255, 184, 0, 0),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage('assets/bbc1.png'),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                'News Name\t',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                'Time\t',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                              SizedBox(width: 85,),
                              IconButton(
                                onPressed: () {
                                },
                                icon: Icon(Icons.bookmark, color: Colors.white,),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Leatest news Heading',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              )),
                          Image(
                            image: AssetImage('assets/1.jpg'),
                            height: 250,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
