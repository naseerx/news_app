import 'package:flutter/material.dart';
import 'package:fyp/pages/headlines_screen_channel.dart';

class InternationalChannels extends StatefulWidget {
  const InternationalChannels({Key? key}) : super(key: key);

  @override
  State<InternationalChannels> createState() => _InternationalChannelsState();
}

class _InternationalChannelsState extends State<InternationalChannels> {

  List channelList = [
    'BBC',
    'Daily Mail',
    'MSN',
  ];
  List channelListTag = [
    'bbc.com',
    'dailymail.co.uk',
    'msn.com',
  ];
  List channelListImages = [
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Padding(
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
                        builder: (context) => HeadlinesScreen(
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
    );
  }
}
