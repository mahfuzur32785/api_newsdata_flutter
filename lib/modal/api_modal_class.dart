import 'dart:convert';

import 'package:api_project_news_api/helper/api_helper.dart';
import 'package:http/http.dart' as http;

class ApiModalClass{

  Future<List<Articles>>fetchNewsData()async{

    List<Articles> apiArticalData = [];

    try{
      var url = "https://newsapi.org/v2/everything?q=bitcoin&apiKey=1039e6f90e5a4cb2a6193bcb7a1127b4";
      var response = await http.get(Uri.parse(url));
      print(response.body);
      var data = jsonDecode(response.body);

      Articles articles;

      for(var i in data["articles"]){
        articles = Articles.fromJson(i);
        apiArticalData.add(articles);
      }
    }catch(e){
      print('The problem is $e');
    }
    return apiArticalData;
  }
}