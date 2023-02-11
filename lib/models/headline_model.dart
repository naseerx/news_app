
import 'dart:convert';

NewsHeadlinesModel newsHeadlinesModelFromJson(String str) => NewsHeadlinesModel.fromJson(json.decode(str));


class NewsHeadlinesModel {
  NewsHeadlinesModel({
    required this.articles,

  });

  List<Article> articles;


  factory NewsHeadlinesModel.fromJson(Map<String, dynamic> json) => NewsHeadlinesModel(
    articles: List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
  );

}

class Article {
  Article({
    required this.title,
    required this.publishedDate,
    required this.excerpt,
    required this.summary,
    required this.authors,
    required this.media,
    required this.clearUrl,

  });

  dynamic title;
  DateTime publishedDate;
  dynamic excerpt;
  String summary;
  dynamic authors;
  dynamic media;
  dynamic clearUrl;


  factory Article.fromJson(Map<String, dynamic> json) =>
      Article(
        title: json["title"],
        publishedDate: DateTime.parse(json["published_date"]),
        excerpt: json["excerpt"],
        summary: json["summary"],
        media: json["media"],
        authors: json["authors"],
        clearUrl: json["clean_url"],

      );
}