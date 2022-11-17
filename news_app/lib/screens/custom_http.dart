import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/model/news_model.dart';
import 'package:news_app/screens/const.dart';

class CustomeHttp {
  Future<List<Articles>> fetchAllNewsData(
      {required int pageNo, required String sortBy}) async {
    List<Articles> allNewsData = [];
    Articles articles;

    var responce = await http.get(Uri.parse(
        "${baseUrl}&q=bitcoin&page=$pageNo&pageSize=1 0&sortBy=$sortBy&apiKey=$token"));
    print("responce is ${responce.body}");

    var data = jsonDecode(responce.body);
    for (var i in data["articles"]) {
      articles = Articles.fromJson(i);
      allNewsData.add(articles);
    }

    return allNewsData;
  }

  Future<List<Articles>> fetchSearchsData({required String query}) async {
    List<Articles> allNewsData = [];
    Articles articles;

    var responce = await http.get(Uri.parse(
        "https://newsapi.org/v2/everything?q=$query&apiKey=f1f697fbcb884fea97366c2bf58fc673"));
    print("responce is ${responce.body}");

    var data = jsonDecode(responce.body);
    for (var i in data["articles"]) {
      articles = Articles.fromJson(i);
      allNewsData.add(articles);
    }

    return allNewsData;
  }
}
