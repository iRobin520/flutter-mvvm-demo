import 'package:flutter_mvvm_demo/generated/json/base/json_convert_content.dart';

class BaseEntity<T> {
	int? code;
	T? data;
	String? msg;

	BaseEntity({this.data, this.code, this.msg});

	BaseEntity.fromJson(Map<String, dynamic> json) {
		if (json['data'] != null && json['data'] != 'null') {
			try {
				if (json['data'] is List) {
					data = JsonConvert.fromJsonAsT<T>(json['data']);
				} else if (json['data'] is bool) {
					data = json['data'] as T;
				} else if (json['data'] is Map && json['data']['list'] != null) {
					data = JsonConvert.fromJsonAsT<T>(json['data']['list']);
				} else {
					data = JsonConvert.fromJsonAsT<T>(json['data']);
				}
			} catch (error) {
				data = json as T;
			}
		}
		code = json['status'];
		msg = json['msg'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.data != null) {
			data['data'] = this.data;
		}
		data['code'] = this.code;
		data['msg'] = this.msg;
		return data;
	}
}
