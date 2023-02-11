import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp/pages/constant.dart';
import 'package:fyp/pages/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../api_key.dart';
import '../models/headline_model.dart';
import 'Explanation_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late StreamController _streamController;
  late Stream stream;
  String token = apiKey;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var dateFormat = DateFormat('dd MM yy h:mm: aa');

  //            *************************************   API   ******************************

  getProfileApi() async {
    try {
      _streamController.add('loading');
      String url =
          'https://api.newscatcherapi.com/v2/latest_headlines?lang=en,ur&sources=bbc.com,dailypakistan.com.pk,propakistani.pk,arynews.tv,geo.tv';
      var response =
          await http.get(Uri.parse(url), headers: {'X-API-KEY': token});
      if (response.statusCode == 200) {
        var dataJson = json.decode(response.body);
        NewsHeadlinesModel getProfileModel =
            NewsHeadlinesModel.fromJson(dataJson);
        _streamController.add(getProfileModel);
        if (kDebugMode) {
          print(dataJson);
        }
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

  logout() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AlertDialog(
            backgroundColor: Kcolor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Column(
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Confirmation !',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                DelayedDisplay(
                  delay: Duration(microseconds: 400),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Are you sure to Quit the App',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            // content: Text('We hate to see you leave...'),
            actions: [
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: DelayedDisplay(
                      delay: const Duration(milliseconds: 800),
                      slidingBeginOffset: const Offset(0.35, 0.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'No',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: DelayedDisplay(
                      delay: const Duration(milliseconds: 1200),
                      slidingBeginOffset: const Offset(0.35, 0.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Yes',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

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
              onPressed: () {
                logout();
              },
            ),
          ],
          backgroundColor: const Color.fromARGB(255, 184, 0, 0),
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
                                    name: data.clearUrl,
                                    data: data,
                                  ),
                                ));
                          },
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: const BorderSide(
                                  width: 3,
                                  color: Colors.white,
                                )),
                            color: const Color.fromARGB(255, 184, 0, 0),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        data.clearUrl.toString().toUpperCase(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          try {
                                            User? user = FirebaseAuth.instance.currentUser;
                                            firestore
                                                .collection('data')
                                                .doc()
                                                .set({
                                              "date": dateFormat.format(data.publishedDate).toString(),
                                              "title": data.title,
                                              "summary": data.summary,
                                              "source": data.clearUrl,
                                              "image": data.media,
                                              "excerpt": data.excerpt,
                                              "uid": user?.uid,
                                            });
                                            print('ok');
                                          } on Exception catch (e) {
                                            print(e.toString());
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.bookmark_border,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    dateFormat.format(data.publishedDate),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    data.title,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Image(
                                    image: NetworkImage(data.media),
                                    height: 250,
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
      ),
    );
  }
}
