import 'dart:convert';
import 'package:flutter_mvvm_demo/generated/json/base/json_field.dart';
import 'package:flutter_mvvm_demo/generated/json/news_entity.g.dart';

@JsonSerializable()
class NewsEntity {

	late String id;
	late String title;
	late String content;
	late String publishDate;
  
  NewsEntity();

  factory NewsEntity.fromJson(Map<String, dynamic> json) => $NewsEntityFromJson(json);

  Map<String, dynamic> toJson() => $NewsEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}