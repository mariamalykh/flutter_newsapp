import 'dart:convert';

import '../models/article.dart';
import 'package:http/http.dart' as http;

class Feed {
  List<ArticleModel> feed = [];


  Future<void> getFeed() async {


    Uri uri = Uri(
      scheme: "https",
      host: 'newsapi.org',
      path: '/v2/everything',
      queryParameters: {'q' : 'tesla',
        'from' : '2024-03-05',
        'sortBy' : 'publishedAt',
        'apiKey': 'e453336138db4d73978a1236cfce06c6'},
    );

    var response = await http.get(uri);

    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if ( element["urlToImage"] != null && element["description"] != null &&
        element['title'] != null && element['author'] != null && element['url'] != null && element['content'] != null) {
          ArticleModel article = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
          );
          feed.add(article);
        }
      });

    }

  }

}