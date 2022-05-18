import 'dart:io';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mvvm_demo/core/base/base_view_model.dart';
import 'package:flutter_mvvm_demo/core/di/inject_provider.dart';
import 'package:flutter_mvvm_demo/core/network/http_client.dart';
import 'package:flutter_mvvm_demo/models/activity_entity.dart';

class ActivityViewModel extends BaseViewModel {
  ActivityViewModel(BuildContext context) : super(context);
  
  HttpClient _client = inject<HttpClient>();
  List<ActivityEntity>? activities = [];

  @override
  Future loadData() async {
    return Future.wait([getActivities()]);
  }
  
  Future getActivities() async {
    return _client.get<List<ActivityEntity>>(url: '/user/activity/getActivitys', parameters: {"position": 2, "visibleDevice":Platform.isIOS ? "iOS": "Android"}, onSuccess: (data){
      activities = data ?? [];
      notifyListeners();
    });
  }
}