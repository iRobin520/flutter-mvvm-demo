import 'package:flutter_mvvm_demo/generated/json/base/json_convert_content.dart';
import 'package:flutter_mvvm_demo/models/activity_entity.dart';

ActivityEntity $ActivityEntityFromJson(Map<String, dynamic> json) {
	final ActivityEntity activityEntity = ActivityEntity();
	final int? activityId = jsonConvert.convert<int>(json['activityId']);
	if (activityId != null) {
		activityEntity.activityId = activityId;
	}
	final String? code = jsonConvert.convert<String>(json['code']);
	if (code != null) {
		activityEntity.code = code;
	}
	final String? url = jsonConvert.convert<String>(json['url']);
	if (url != null) {
		activityEntity.url = url;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		activityEntity.name = name;
	}
	final int? totalChance = jsonConvert.convert<int>(json['totalChance']);
	if (totalChance != null) {
		activityEntity.totalChance = totalChance;
	}
	final int? remainChance = jsonConvert.convert<int>(json['remainChance']);
	if (remainChance != null) {
		activityEntity.remainChance = remainChance;
	}
	final String? startTime = jsonConvert.convert<String>(json['startTime']);
	if (startTime != null) {
		activityEntity.startTime = startTime;
	}
	final String? endTime = jsonConvert.convert<String>(json['endTime']);
	if (endTime != null) {
		activityEntity.endTime = endTime;
	}
	final String? activityStatus = jsonConvert.convert<String>(json['activityStatus']);
	if (activityStatus != null) {
		activityEntity.activityStatus = activityStatus;
	}
	return activityEntity;
}

Map<String, dynamic> $ActivityEntityToJson(ActivityEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['activityId'] = entity.activityId;
	data['code'] = entity.code;
	data['url'] = entity.url;
	data['name'] = entity.name;
	data['totalChance'] = entity.totalChance;
	data['remainChance'] = entity.remainChance;
	data['startTime'] = entity.startTime;
	data['endTime'] = entity.endTime;
	data['activityStatus'] = entity.activityStatus;
	return data;
}