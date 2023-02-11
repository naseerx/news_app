import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'constant.dart';

class BookMarkDetailsScreen extends StatefulWidget {
  final String image;
  final String source;
  final String summary;
  final String date;
  final String title;
  final String excerpt;
  final String id;

  const BookMarkDetailsScreen({
    Key? key,
    required this.image,
    required this.title,
    required this.source,
    required this.summary,
    required this.date,
    required this.excerpt,
    required this.id,
  }) : super(key: key);

  @override
  State<BookMarkDetailsScreen> createState() => _BookMarkDetailsScreenState();
}

class _BookMarkDetailsScreenState extends State<BookMarkDetailsScreen> {
  var dateFormat = DateFormat('dd MM yy h:mm: aa');

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: Bimg,
        fit: BoxFit.cover,
      )),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 184, 0, 0),
            title: const Text('Explanation Screen'),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout_outlined),
                onPressed: () {},
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(3),
            child: SingleChildScrollView(
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(
                      width: 4,
                      color: Colors.white,
                    )),
                color: const Color.fromARGB(255, 184, 0, 0),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.source.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget.date,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: ()async {
                              try {
                                await FirebaseFirestore
                                    .instance
                                    .collection('data')
                                    .doc(widget.id)
                                    .delete();
                                print(
                                 'Deleted');
                                setState(() {});
                              } catch (e) {
                             print('failed');
                              }
                            },
                            icon: const Icon(
                              Icons.bookmark,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        widget.title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image(
                            image: NetworkImage(widget.image),
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            widget.summary.isEmpty
                                ? widget.excerpt
                                : widget.summary,
                            style: const TextStyle(
                                color: Colors.white,
                                letterSpacing: 1.1,
                                wordSpacing: 1.3,
                                fontSize: 16),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
