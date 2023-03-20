import 'package:intl/intl.dart';

class Article {
  String? title, author, source, description, urlToImage, content, url;
  int? id;
  DateTime ?publishedAt;
  Article(
      {String? title, author, source,description,url,urlToImage,content,
        int? id,DateTime ?publishedAt }) {
    this.id = id;
    this.title = title;
    this.author = author;
    this.source = source;
    this.publishedAt = publishedAt;
    this.description=description;
    this.url=url;
    this.content=content;
    this.urlToImage=urlToImage;



  }

  factory Article.fromJson(Map<String, dynamic> json) {

   DateTime date =  DateFormat("yyyy-MM-dd").parse(json["publishedAt"]);

    return Article(

      title: json["title"] ?? '',
      author: json["author"] ?? '',
      source: json["source"]["name"] ?? '',
   description: json['description'],
    url:json['url'],
    urlToImage: json['urlToImage'],
    publishedAt :date,
    content: json['content'],

    );
  }
}
