import 'package:flutter_mvvm_demo/generated/json/base/json_convert_content.dart';
import 'package:flutter_mvvm_demo/models/banner_entity.dart';

BannerEntity $BannerEntityFromJson(Map<String, dynamic> json) {
	final BannerEntity bannerEntity = BannerEntity();
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		bannerEntity.title = title;
	}
	final String? imageUrl = jsonConvert.convert<String>(json['imageUrl']);
	if (imageUrl != null) {
		bannerEntity.imageUrl = imageUrl;
	}
	final String? imageLink = jsonConvert.convert<String>(json['imageLink']);
	if (imageLink != null) {
		bannerEntity.imageLink = imageLink;
	}
	return bannerEntity;
}

Map<String, dynamic> $BannerEntityToJson(BannerEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['title'] = entity.title;
	data['imageUrl'] = entity.imageUrl;
	data['imageLink'] = entity.imageLink;
	return data;
}