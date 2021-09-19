import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_newsapi/categorydata.dart';
import 'package:flutter_application_newsapi/model/ctegory.dart';
import 'package:flutter_application_newsapi/model/newsapi.dart';
import 'package:flutter_application_newsapi/newsdata.dart';

import 'newsdata.dart';

class categorydetail extends StatefulWidget {
  String? category;
  categorydetail({Key? key, this.category}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<categorydetail> {
  List<CategoryModel> categories = <CategoryModel>[];
  List<ArticleModel> articles = <ArticleModel>[];
  bool _isloading = true;

  getnews() async {
    CategoryNews newsdata = CategoryNews();
    await newsdata.getNews(widget.category!);

    articles = newsdata.datatobesavedin;
    setState(() {
      _isloading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getnews();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          elevation: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment
                .center, // this is to bring the row text in center
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 50),
                child: Text(
                  widget.category!.toUpperCase(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        body: _isloading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        child: ListView.builder(
                            itemCount: articles.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (ctx, index) {
                              return newstemp(
                                  urlToImage: articles[index].urlToImage,
                                  title: articles[index].title,
                                  description: articles[index].description);
                            }),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget newstemp(
      {String? title, String? description, String? url, String? urlToImage}) {
    return Column(
      children: [
        Image.network(urlToImage!, width: 380, height: 200, fit: BoxFit.cover),
        Text(
          title!,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          description!,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
