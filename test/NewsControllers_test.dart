import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/Controllers/NewsController.dart';
import 'package:news_app/Models/Article.dart';
import 'package:news_app/Static/Server.dart';



void main() {

  group('getNewsResponse', () {
    test(' check If news response is not null',
            () async {

              List<Article> articles;
              articles = await  NewsController().getAllNewsFromApi("https://newsapi.org/v2/top-headlines?category=science&pageSize=40&apiKey=${Server.apiKey}");


          final article = Article(
              title: articles[0].title,
              author: articles[0].author,
              source: articles[0].source,
              description:articles[0].description,
              url:articles[0].url,
              urlToImage:articles[0].urlToImage,
              content:articles[0].content

          );

          expect(article,isNotNull);
        });


    test(' check If search news response is not null',
            () async {

          List<Article> articles;
          articles = await    NewsController().getAllNewsFromApi("https://newsapi.org/v2/everything?q=sport&sortBy=popularity&apiKey=${Server.apiKey}");


          final article2 = Article(
              title: articles[0].title,
              author: articles[0].author,
              source: articles[0].source,
              description:articles[0].description,
              url:articles[0].url,
              urlToImage:articles[0].urlToImage,
              content:articles[0].content

          );

          expect(article2,isNotNull);
        });


  });



}