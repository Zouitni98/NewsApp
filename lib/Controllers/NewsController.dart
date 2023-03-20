import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Models/Article.dart';
import 'package:news_app/Models/NewsModel.dart';
import '../Static/Server.dart';

class NewsController extends GetxController{

  final dio = Dio();

  // for list view
  List<Article> allNews = <Article>[];
  // for carousel
  ScrollController scrollController = ScrollController();
  RxBool articleNotFound = false.obs;
  RxBool isLoading = false.obs;
  RxString category = ''.obs;
  RxString searchNews = ''.obs;
  RxInt pageNum = 1.obs;


  String baseUrl = Server.url;

  @override
  void onInit() {
    scrollController = ScrollController()..addListener(_scrollListener);
    getAllNews();
    super.onInit();
  }

  _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isLoading.value = true;
      getAllNews();
    }
  }


  // function to load and display all news and searched news on to UI
  getAllNews({ searchKey = '', reload = false}) async {
    articleNotFound.value = false;

    if (!reload && isLoading.value == false) {
    } else {
      category.value = '';
    }
    if (isLoading.value == true) {
      pageNum++;
    } else {
      allNews = [];

      pageNum.value = 2;
    }
    // ENDPOINT
    baseUrl = "https://newsapi.org/v2/top-headlines?category=science&pageSize=100&apiKey=${Server.apiKey}";

    if (searchKey != '') {
      print("searchKey");
      print(searchKey);
      baseUrl =
      "https://newsapi.org/v2/everything?q=$searchKey&sortBy=popularity&apiKey=${Server.apiKey}";
    }
    print(baseUrl);
    // calling the API function and passing the URL here
    getAllNewsFromApi(baseUrl);
  }


  // function to retrieve a JSON response for all news from newsApi.org
  Future<List<Article>> getAllNewsFromApi(url) async {
    //Creates a new Uri object by parsing a URI string.
    final res = await dio.get(url);
    // http.Response res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      //Parses the string and returns the resulting Json object.
      NewsModel newsData = NewsModel.fromJson(res.data);

      if (newsData.articles.isEmpty && newsData.totalResults == 0) {
        articleNotFound.value = isLoading.value == true ? false : true;
        isLoading.value = false;
        update();
      } else {
        if (isLoading.value == true) {
          // combining two list instances with spread operator
          allNews = [...allNews, ...newsData.articles];
          update();
        } else {
          if (newsData.articles.isNotEmpty) {
            allNews = newsData.articles;
            // list scrolls back to the start of the screen
            if (scrollController.hasClients) scrollController.jumpTo(0.0);
            update();
          }
        }
        articleNotFound.value = false;
        isLoading.value = false;
        update();
      }
    } else {
      articleNotFound.value = true;
      update();
    }
    return allNews;
  }


  // function to retrieve a JSON response for all news from newsApi.org


}
