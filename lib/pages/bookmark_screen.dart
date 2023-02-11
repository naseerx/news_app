import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/get_data_model.dart';
import 'bookmark_details_screen.dart';
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
          title: Text('saved'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
            IconButton(
              icon: const Icon(Icons.logout_outlined),
              onPressed: () {},
            ),
          ],
          elevation: 6,
          backgroundColor: Color.fromARGB(255, 184, 0, 0),
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
                                                  excerpt: data.excerpt, id:ds.id,),
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
