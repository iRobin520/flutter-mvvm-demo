import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mvvm_demo/core/base/base_entity.dart';
import 'package:flutter_mvvm_demo/core/utils/storage_helper.dart';


class HttpClient {
  late Dio _client;
  static const String BASE_URL = 'https://core-api.blockbzz.cn';
  static const int CONNECT_TIMEOUT = 10000;
  static const int RECEIVE_TIMEOUT = 10000;

  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';

  ///构造器
  HttpClient() {
    _client = Dio();
    _client.options =  BaseOptions(baseUrl: BASE_URL, connectTimeout: CONNECT_TIMEOUT, receiveTimeout: RECEIVE_TIMEOUT);
    _client.interceptors.add(_interceptor());
  }

  ///拦截器
  Interceptor _interceptor() {
    return InterceptorsWrapper(onRequest: (request, handler) async {
          var storageToken = await StorageHelper.get(StorageKeys.token);
          if (storageToken != null) request.headers.addAll({
            "Authorization": 'Bearer $storageToken',
          });
          debugPrint("\r----------【请求url】----------\r\n${request.uri}");
          debugPrint("\r----------【请求headers】----------\r\n${request.headers.toString()}");
          if (request.method == "GET") {
            debugPrint("\r----------【请求参数】----------\r\n${request.queryParameters}");
          }
          if (request.method == "POST") {
            debugPrint("\r----------【请求参数】----------\r\n${request.data}");
          }
          return handler.next(request); //continue
        },
        onResponse: (response, handler) {
          debugPrint("\r----------【请求结果】----------\r\n${response.data.toString()}");
          return handler.next(response);
        },
        onError: (DioError error, handler) async {
          debugPrint("---------- 网络请求失败: ----------");
          if (error.type == DioErrorType.connectTimeout) {
            debugPrint("连接超时");
          } else if (error.type == DioErrorType.sendTimeout) {
            debugPrint("请求超时");
          } else if (error.type == DioErrorType.receiveTimeout) {
            debugPrint("响应超时");
          } else if (error.type == DioErrorType.response) {
            debugPrint("出现异常404 503");
          } else if (error.type == DioErrorType.cancel) {
            debugPrint("请求取消");
          } else {
            debugPrint("message = ${error.message}");
          }
          return handler.next(error);
        }
    );
  }

  ///Get请求
  void get<T>( {required String url, parameters, Function(T? t)? onSuccess,  Function(String error)? onError }) async {
    doRequest<T>(url: url,method: GET ,parameters: parameters,onSuccess: onSuccess,onError: onError);
  }

  ///Post请求
  void post<T>({required String url, parameters, Function(T? t)? onSuccess, Function(String error)? onError })  async {
    doRequest<T>(url: url, method: POST, parameters: parameters, onSuccess: onSuccess, onError: onError);
  }

  ///@ url 请求链接
  ///@ parameters 请求参数
  ///@ method 请求方式
  Future<T?> request<T>({required String url, parameters, method}) async {
    parameters = parameters ?? {};
    method = method ?? 'GET';

    /// 请求处理
    parameters.forEach((key, value) {
      if (url.indexOf(key) != -1) {
        url = url.replaceAll(':$key', value.toString());
      }
    });

    //请求结果
    var result;
    try {
      Response response = await _client.request(url, data: parameters, options: new Options(method: method));
      /// 拦截http层异常码
      if (response.statusCode == 200) {
        BaseEntity<T>entity = BaseEntity.fromJson(response.data);
        if(entity.code == 200) {
          result = entity.data;
        } else {
          throw Exception(entity.msg);
        }
      } else {
        throw Exception('statusCode:${response.statusCode}+${response.statusMessage}');
      }
    } on DioError catch (e) {
      throw Exception(e.toString());
    }
    return result;
  }

  void doRequest<T>({required String url, required String method, parameters, Function(T? t)? onSuccess, Function(String error)? onError}) async {
    try {
      Response response;
      parameters = parameters ?? {};
      parameters = new Map<String, dynamic>.from(parameters);
      switch(method){
        case GET:
          response = await _client.get(url, queryParameters: parameters);
          break;
        case PUT:
          response = await _client.put(url, queryParameters: parameters);
          break;
        case PATCH:
          response = await _client.patch(url, queryParameters: parameters);
          break;
        case DELETE:
          response = await _client.delete(url, queryParameters: parameters);
          break;
        default:
          response = await _client.post(url, data: parameters);
          break;
      }
      /// 拦截http层异常码
      if (response.statusCode == 200) {
        /// 这里做baseEntity泛型解析，封装 并拦截后台code异常码，可拦截自定义处理
        BaseEntity<T> entity = BaseEntity.fromJson(response.data);
        if(entity.code == 0 && onSuccess != null) {
          ///返回泛型Entity
          onSuccess(entity.data);
        } else {
          if (onError != null) {
            onError(entity.msg!);
          }
        }
      } else {
        throw Exception('statusCode:${response.statusCode}+${response.statusMessage}');
      }
    } catch (e) {
      if (onError != null) {
        onError(e.toString());
      }
    }
  }
}