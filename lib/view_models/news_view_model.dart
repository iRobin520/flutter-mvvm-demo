import 'package:flutter/material.dart';
import 'package:flutter_mvvm_demo/core/base/base_view_model.dart';
import 'package:flutter_mvvm_demo/core/di/inject_provider.dart';
import 'package:flutter_mvvm_demo/core/network/mock_client.dart';
import 'package:flutter_mvvm_demo/models/news_entity.dart';

class NewsViewModel extends BaseViewModel {
  final String newsId;
  NewsViewModel(this.newsId, BuildContext context) : super(context);

  MockClient _client = inject<MockClient>();
  NewsEntity? newsDetail;

  @override
  Future loadData() async {
    newsDetail = await _client.getNewsDetail(newsId);
    notifyListeners();
    return newsDetail;
  }
}