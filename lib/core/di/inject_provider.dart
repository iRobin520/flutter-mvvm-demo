import 'package:flutter_mvvm_demo/core/di/navigate_service.dart';
import 'package:flutter_mvvm_demo/core/network/http_client.dart';
import 'package:flutter_mvvm_demo/core/network/mock_client.dart';
import 'package:get_it/get_it.dart';

final GetIt inject = GetIt.I;

Future<void> setupInjection() async {

  //导航服务
  inject.registerSingleton(NavigateService());

  //注入组件
  inject.registerSingleton(HttpClient());
  inject.registerSingleton(MockClient());
}