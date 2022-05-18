import 'package:flutter/material.dart';
import 'package:flutter_mvvm_demo/core/widgets/app_page_widget.dart';
import 'package:flutter_mvvm_demo/view_models/news_view_model.dart';
import 'package:provider/provider.dart';

class NewsDetailPage extends StatefulWidget {
  final String id;
  const NewsDetailPage({Key? key, required this.id}): super(key: key);

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewsViewModel>(
        create: (context) => NewsViewModel(widget.id, context),
        child: Builder(builder: (context) {
          var newsDetail = context.watch<NewsViewModel>().newsDetail;
          return AppPageWidget(
              title: 'news details',
              contentBody: newsDetail != null ?  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(newsDetail.title,
                      style: TextStyle(
                        fontSize: 16,
                      )
                  ),
                  SizedBox(height: 10),
                  Divider(height: 0.5, thickness: 0.5, color: Colors.grey),
                  SizedBox(height: 10),
                  Text(newsDetail.content,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5
                      )
                  ),
                ],
              ) : Center(
                child: Text('数据加载中...'),
              )
          );
        }));
  }
}