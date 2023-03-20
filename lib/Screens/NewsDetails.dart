

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Widgets/WebViewNews.dart';
import 'package:news_app/Widgets/customAppBar.dart';
class NewsDetails extends StatelessWidget {


final String imgUrl, title, desc, content, postUrl,author,source,publishedDate;

const NewsDetails(
{super.key,
required this.imgUrl,
required this.desc,
required this.title,
required this.content,
required this.postUrl,required this.author,required this.source,required this.publishedDate});


@override
Widget build(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  List datesplited = publishedDate.toString().split(" ");
  String date = datesplited[0];
  return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: customAppBar('News App', context),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.4,
                child:     CachedNetworkImage(
                  imageUrl: imgUrl,
                  fit: BoxFit.fill,
                  height: size.width*0.7,
                  width: MediaQuery.of(context).size.width,
                  errorWidget: (context, url, error) =>  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child:  SizedBox(
                      height: size.height*0.5,
                      width: double.infinity,
                      child: const Icon(Icons.broken_image_outlined,size: 50,color: Colors.grey,),
                    ),
                  ),
                ),
              ),
              Container(
                  width: size.width *0.95,
                  color: Colors.white,
                  padding: const EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        SizedBox(
                          width: size.width * 0.9,
                          child: Text(
                              title!.isNotEmpty
                                  ? title
                                  : "",
                              //overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.roboto(
                                  fontSize: 20.0,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 10),
                                child: Text(
                                  author.isNotEmpty
                                      ? author:"",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                              Row(
                                children: [


                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    icon:  Icon(
                                      CupertinoIcons.clock_fill,
                                      color: Colors.blue[300],
                                      size: 19,
                                    ),
                                    onPressed: () {},
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5.0, right: 10),
                                    child: Text(
                                      publishedDate.isNotEmpty
                                          ? date:"",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Divider(
                            thickness: 3,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                           content,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 18,
                                height: 1.5,
                                fontWeight: FontWeight.w300,
                                color: Colors.black87),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: (){
                                 Get.to(() => WebViewNews(newsUrl: postUrl!));

                              },
                              child: Text(
                                source.isNotEmpty
                                    ? "Source Link :"+ source:"",
                                textAlign: TextAlign.left,
                                style:  TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.blue[300]),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
   );
}
}





