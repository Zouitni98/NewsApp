
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Controllers/NewsController.dart';
import 'package:news_app/Screens/NewsDetails.dart';
import 'package:news_app/Static/AppColors.dart';
import 'package:news_app/Widgets/NewsCard.dart';
import 'package:news_app/Widgets/customAppBar.dart';

class NewsScreen extends StatelessWidget {
  NewsScreen({Key? key}) : super(key: key);
  NewsController newsController = Get.put(NewsController());
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: customAppBar('News App', context, actions: [
        IconButton(
          onPressed: () {
            newsController.category.value = '';
            newsController.searchNews.value = '';
            newsController.getAllNews(reload: true);
            newsController.update();
          },
          icon: const Icon(Icons.refresh),
        ),
      ]),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                margin:const  EdgeInsets.symmetric(
                    horizontal: 18, vertical: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  boxShadow: const[
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 7,
                      offset: Offset(1, 1), // Shadow position
                    ),
                  ],
                ),

                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(left:16),
                        child: TextField(
                          controller: searchController,
                          textInputAction: TextInputAction.search,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search News"),
                          onChanged: (val) {
                            newsController.searchNews.value = val;
                            newsController.update();
                          },
                          onSubmitted: (value) async {
                            newsController.searchNews.value = value;
                            newsController.getAllNews(
                                searchKey: newsController.searchNews.value);
                            searchController.clear();
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          color: AppColors.blue,
                          onPressed: () async {
                            newsController.getAllNews(
                                searchKey: newsController.searchNews.value);
                            searchController.clear();
                          },
                          icon: const Icon(Icons.search_sharp)),
                    ),
                  ],
                ),
              ),
            ),

            GetBuilder<NewsController>(
                init: NewsController(),
                builder: (controller) {
                  return controller.articleNotFound.value
                      ? const Center(
                    child: Text('Nothing Found'),
                  )
                      : controller.allNews.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                      controller: controller.scrollController,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.allNews.length,
                      itemBuilder: (context, index) {

                        index == controller.allNews.length - 1 &&
                            controller.isLoading.isTrue
                            ? const Center(
                          child: CircularProgressIndicator(),
                        )
                            : const SizedBox();
                        return InkWell(
                          onTap: () {


                            Get.to(() =>  NewsDetails(
                                source: controller
                                    .allNews[index].source ??
                                    '',
                                publishedDate: controller
                                    .allNews[index].publishedAt.toString()
                                ,
                                imgUrl: controller
                                    .allNews[index].urlToImage ??
                                    '',
                                desc: controller
                                    .allNews[index].description ??
                                    '',
                                title: controller.allNews[index].title!,
                                content:
                                controller.allNews[index].content ??
                                    '',
                                postUrl: controller.allNews[index].url!, author: controller
                                .allNews[index].author ??
                                '',));
                          },
                          child: NewsCard(
                            author: controller
                                .allNews[index].author ??
                                '',
                              source: controller
                                  .allNews[index].source ??
                                  '',
                              publishedDate: controller
                                  .allNews[index].publishedAt.toString()
                                  ,
                              imgUrl: controller
                                  .allNews[index].urlToImage ??
                                  '',
                              desc: controller
                                  .allNews[index].description ??
                                  '',
                              title: controller.allNews[index].title!,
                              content:
                              controller.allNews[index].content ??
                                  '',
                              postUrl: controller.allNews[index].url!),
                        );
                      });
                }),
          ],
        ),
      ),
    );
  }
}