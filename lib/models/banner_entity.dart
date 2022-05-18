import 'dart:convert';
import 'package:flutter_mvvm_demo/generated/json/base/json_field.dart';
import 'package:flutter_mvvm_demo/generated/json/banner_entity.g.dart';

@JsonSerializable()
class BannerEntity {

	late String title;
	late String imageUrl;
	late String imageLink;
  
  BannerEntity();

  factory BannerEntity.fromJson(Map<String, dynamic> json) => $BannerEntityFromJson(json);

  Map<String, dynamic> toJson() => $BannerEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}