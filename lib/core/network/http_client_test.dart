import 'package:flutter_mvvm_demo/core/di/inject_provider.dart';
import 'package:flutter_mvvm_demo/models/banner_entity.dart';
import 'http_client.dart';

class HttpClientTest {
  final HttpClient _client = inject<HttpClient>();

  ///回调方式调用(支持泛型-返回模型列表)
  void getTestByCallback1() {
    _client.get<List<BannerEntity>>(url: 'banners', parameters: null, onSuccess: (data) {

    }, onError: (error) {

    });
  }

  ///回调方式调用(支持泛型-返回模型)
  void getTestByCallback2() {
    _client.get<BannerEntity>(url: 'banners/1', parameters: null, onSuccess: (data) {

    }, onError: (error) {

    });
  }

  ///回调方式调用(支持泛型-返回字典)
  void getTestByCallback3() {
    _client.get<Map>(url: 'banners', parameters: null, onSuccess: (data) {

    }, onError: (error) {

    });
  }

  ///Future方式调用(支持泛型-返回模型列表)
  void getTestByFuture1() {
    _client.request<List<BannerEntity>>(url: 'banners', parameters: null, method: HttpClient.GET).then((data){

    }).catchError((error){

    });
  }

  ///Future方式调用(支持泛型-返回模型)
  void getTestByFuture2() {
    _client.request<BannerEntity>(url: 'banners/1', parameters: null, method: HttpClient.GET).then((data){

    }).catchError((error){

    });
  }

  ///Future方式调用(支持泛型-返回字典)
  void getTestByFuture3() {
    _client.request<Map>(url: 'banners',parameters: null, method: HttpClient.GET).then((data){

    }).catchError((error){

    });
  }
}