import 'package:flutter/material.dart';
import 'package:news_app/Static/ui_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NewsCard extends StatelessWidget {
  final String imgUrl, title, desc, content, postUrl,author,source,publishedDate;

  const NewsCard(
      {super.key,
        required this.imgUrl,
        required this.desc,
        required this.title,
        required this.content,
        required this.postUrl,required this.author,required this.source,required this.publishedDate});

  @override
  Widget build(BuildContext context) {
    List datesplited = publishedDate.toString().split(" ");
    String date = datesplited[0];
    Size size = MediaQuery.of(context).size;
    return Card(
      elevation: 4,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      margin: const EdgeInsets.fromLTRB(
          16, 0, 16,16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10)),
              child:

              CachedNetworkImage(
                imageUrl: imgUrl,
                fit: BoxFit.fill,
                height: size.width*0.5,
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


          SizedBox(width: size.height*0.1),
          Padding(
            padding: const EdgeInsets.all(6),
            child: Text(
              title,
              maxLines: 2,
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6),
            child: Text(
              desc,
              maxLines: 2,
              style: const TextStyle(color: Colors.black54, fontSize: 14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6),
            child: Text(
             " Author: $author",
              maxLines: 2,
              style: const TextStyle(color: Colors.black54, fontSize: 14),
            ),
          ),
          Padding(
            padding:  const EdgeInsets.all(6),
            child: Text(
              " Source: $source",
              maxLines: 2,
              style: const TextStyle(color: Colors.black54, fontSize: 14),
            ),
          ),
          Padding(
            padding:  const EdgeInsets.all(6),
            child: Text(
              " Published Date: $date",
              maxLines: 2,
              style: const TextStyle(color: Colors.black54, fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}