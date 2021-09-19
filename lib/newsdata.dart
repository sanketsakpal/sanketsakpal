import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/newsapi.dart';

class News {
  // save json data inside this
  List<ArticleModel> datatobesavedin = [];

  getNews() async {
    var response = await http.get(Uri.parse(
        'http://newsapi.org/v2/top-headlines?country=us&apiKey=4298627224554a7d9ab8f95ca7177f74'));
    var jsonData = jsonDecode(response.body);
    // print(jsonData['articles'].forEach(Element));

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          // initliaze our model class

          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            urlToImage: element['urlToImage'],
            description: element['description'],
            url: element['url'],
          );

          datatobesavedin.add(articleModel);
        }
      });
    }
  }
}

// fetching news by  category
class CategoryNews {
  List<ArticleModel> datatobesavedin = [];

  Future<void> getNews(String category) async {
    var response = await http.get(Uri.parse(
        'http://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=4298627224554a7d9ab8f95ca7177f74'));
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          // initliaze our model class

          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            urlToImage: element['urlToImage'],
            description: element['description'],
            url: element['url'],
          );

          datatobesavedin.add(articleModel);
        }
      });
    }
  }
}
