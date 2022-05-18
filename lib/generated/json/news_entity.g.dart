import 'package:flutter_mvvm_demo/generated/json/base/json_convert_content.dart';
import 'package:flutter_mvvm_demo/models/news_entity.dart';

NewsEntity $NewsEntityFromJson(Map<String, dynamic> json) {
	final NewsEntity newsEntity = NewsEntity();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		newsEntity.id = id;
	}
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		newsEntity.title = title;
	}
	final String? content = jsonConvert.convert<String>(json['content']);
	if (content != null) {
		newsEntity.content = content;
	}
	final String? publishDate = jsonConvert.convert<String>(json['publishDate']);
	if (publishDate != null) {
		newsEntity.publishDate = publishDate;
	}
	return newsEntity;
}

Map<String, dynamic> $NewsEntityToJson(NewsEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['title'] = entity.title;
	data['content'] = entity.content;
	data['publishDate'] = entity.publishDate;
	return data;
}