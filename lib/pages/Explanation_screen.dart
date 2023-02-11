import 'package:flutter/material.dart';
import 'package:fyp/models/headline_model.dart';
import 'package:intl/intl.dart';

import 'constant.dart';

class ExplanationScreen extends StatefulWidget {
  final String tag;
  final String name;
  final String image;
  final Article data;
  const ExplanationScreen({
    Key? key,
    required this.tag,
    required this.name,
    required this.image,
    required this.data,
  }) : super(key: key);

  @override
  State<ExplanationScreen> createState() => _ExplanationScreenState();
}

class _ExplanationScreenState extends State<ExplanationScreen> {
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
            title: Text('Explanation Screen'),
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
                          CircleAvatar(
                            backgroundImage: AssetImage(widget.image),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                dateFormat.format(widget.data.publishedDate),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {},
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
                        widget.data.title,
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
                            image: NetworkImage(widget.data.media),
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            widget.data.summary.isEmpty ? widget.data.excerpt: widget.data.summary,
                            style: const TextStyle(color: Colors.white,letterSpacing: 1.1,wordSpacing: 1.3,fontSize: 16),
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
