import 'dart:convert';
import 'package:flutter_mvvm_demo/generated/json/base/json_field.dart';
import 'package:flutter_mvvm_demo/generated/json/activity_entity.g.dart';

@JsonSerializable()
class ActivityEntity {

	late int activityId;
	late String code;
	late String url;
	late String name;
	late int totalChance;
	late int remainChance;
	late String startTime;
	late String endTime;
	late String activityStatus;
  
  ActivityEntity();

  factory ActivityEntity.fromJson(Map<String, dynamic> json) => $ActivityEntityFromJson(json);

  Map<String, dynamic> toJson() => $ActivityEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }

	//{"activityId": 65, "code": "zhaocaihuxf011303", "url": "https://versecore-prod.oss-cn-shanghai.aliyuncs.com/nft/icon/祝福虎-动效_1642045870261.gif", "name": "招财虎-幸福", "totalChance": 3333, "remainChance": 0, "startTime": "1642060800000", "endTime": "1642348800000", "activityStatus": "ACTIVITY_END"}
}