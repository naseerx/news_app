import 'package:flutter/material.dart';

import 'headlines_screen_topic.dart';
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List channelList = [
    'Sports News',
    'Tech News',
    'Food News',
    'Business News',
    'Entertainment News',
    'Politics News',
    'Science News',
  ];
  List channelListTag = [
    'sport',
    'tech',
    'food',
    'business',
    'entertainment',
    'politics',
    'science'
  ];
  List channelListImages = [
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.deepPurple, Colors.deepPurple, Colors.pink],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.only(
            left: 5,
            top: 1,
            right: 5,
          ),
          child: ListView.builder(
            itemCount: channelList.length,
            itemBuilder: (BuildContext ctx, index) {
              return Padding(
                padding: const EdgeInsets.only(
                  left: 5,
                  top: 1,
                  bottom: 1,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HeadlinesScreenTopics(
                            tag: channelListTag[index],
                            name: channelList[index],
                            image: channelListImages[index],
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
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image(
                              image: AssetImage(
                                channelListImages[index],
                              ),
                              height: 190,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              channelList[index],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
