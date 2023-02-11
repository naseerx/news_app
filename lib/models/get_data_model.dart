import 'package:cloud_firestore/cloud_firestore.dart';

class GetBookMarkModel {
  String image;
  String source;
  String uid;
  String summary;
  String date;
  String title;
  String excerpt;

  GetBookMarkModel(
      {required this.image,
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
