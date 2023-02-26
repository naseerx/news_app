//Book mArk screen add this in your main screen line 1 to 190

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'constant.dart';

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({Key? key}) : super(key: key);

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  var dateFormat = DateFormat('dd MM yy h:mm: aa');

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('saved'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            IconButton(
              icon: const Icon(Icons.logout_outlined),
              onPressed: () {},
            ),
          ],
          elevation: 6,
          backgroundColor: const Color.fromARGB(255, 184, 0, 0),
        ),
        backgroundColor: Colors.transparent,
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('data')
              .where("uid", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            } else {
              return snapshot.data!.docs.isNotEmpty
                  ? ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot ds = snapshot.data!.docs[index];
                        GetBookMarkModel data = GetBookMarkModel.fromMap(
                            snapshot.data!.docs[index]);
                        return snapshot.data!.docs.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(2),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BookMarkDetailsScreen(
                                            image: data.image,
                                            title: data.title,
                                            source: data.source,
                                            summary: data.summary,
                                            date: data.date,
                                            excerpt: data.excerpt,
                                            id: ds.id,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: data.image.isNotEmpty
                                                    ? FadeInImage(
                                                        height: 100,
                                                        width: 100,
                                                        placeholder:
                                                            const AssetImage(
                                                                'assets/1.jpg'),
                                                        image: NetworkImage(
                                                            data.image))
                                                    : Image.asset(
                                                        'assets/1.jpg',
                                                        height: 100,
                                                        width: 100,
                                                      ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data.source,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    data.date,
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
                              )
                            : const Center(
                                child: Text(
                                  'No Bookmark added yet',
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                      },
                    )
                  : const Center(
                      child: Text(
                        'No Bookmark added yet',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    );
            }
          },
        ),
      ),
    );
  }
}

//Book mark details screen add this in your bookmark screen. line 190 to 342

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
                            onPressed: () async {
                              try {
                                await FirebaseFirestore.instance
                                    .collection('data')
                                    .doc(widget.id)
                                    .delete();
                                print('Deleted');
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



//Book mark model add this in your model folder inside a dart file. line 349 to last



class GetBookMarkModel {
  String image;
  String source;
  String uid;
  String summary;
  String date;
  String title;
  String excerpt;

  GetBookMarkModel({
    required this.image,
    required this.uid,
    required this.summary,
    required this.excerpt,
    required this.date,
    required this.source,
    required this.title,
  });

  factory GetBookMarkModel.fromMap(DocumentSnapshot snapshot) {
    return GetBookMarkModel(
      image: snapshot['image'],
      source: snapshot['source'],
      date: snapshot['date'],
      summary: snapshot['summary'],
      excerpt: snapshot['excerpt'],
      title: snapshot['title'],
      uid: snapshot['uid'],
    );
  }
}
