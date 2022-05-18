import 'package:flutter/material.dart';
import 'package:flutter_mvvm_demo/core/utils/object_parser.dart';
import 'package:flutter_mvvm_demo/views/activity_page.dart';
import 'package:flutter_mvvm_demo/views/news_detail_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  var arguments = settings.arguments;
  switch(settings.name) {
    case 'NewsDetailPage':
      final newsId = ObjectParser.parseParam<String?>("newsId", arguments);
      return MaterialPageRoute(builder: (context) => NewsDetailPage(id: newsId ?? '0'));
    case 'ActivityList':
      return MaterialPageRoute(builder: (context) => ActivityPage());
    default:
      return MaterialPageRoute(builder: (BuildContext context) {
        return Scaffold(
            body: Center(
              child: Text("Page not found"),
            ));
      });
  }
}
