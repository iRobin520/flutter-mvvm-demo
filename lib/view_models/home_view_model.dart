import 'package:flutter/material.dart';
import 'package:flutter_mvvm_demo/core/base/base_view_model.dart';
import 'package:flutter_mvvm_demo/core/network/http_client.dart';
import 'package:flutter_mvvm_demo/core/di/inject_provider.dart';
import 'package:flutter_mvvm_demo/core/network/mock_client.dart';
import 'package:flutter_mvvm_demo/core/widgets/banner_widget.dart';
import 'package:flutter_mvvm_demo/models/banner_entity.dart';

class HomeViewModel extends BaseViewModel {
  HomeViewModel(BuildContext context) : super(context);

  MockClient _client = inject<MockClient>();
  List<BannerEntity>? banners;
  bool isLiked = false;
  int likedCount = 45;

  @override
  Future loadData() async {
    //banners = await _client.request<List<BannerEntity>>(url: 'banners',parameters: null, method: HttpClient.GET);
    banners = await _client.getBanners();
    notifyListeners();
    return banners;
  }

  List<BannerItem> getBannerItems() {
    List<BannerItem> bannerList = [];
    if (banners != null) {
      banners!.forEach((element) {
        BannerItem item = BannerItem.defaultBannerItem(element.imageUrl,element.title.toString());
        bannerList.add(item);
      });
    }
    return bannerList;
  }

  void toggleLike() {
    if(isLiked) {
      --likedCount;
    } else {
      ++likedCount;
    }
    isLiked = !isLiked;
    notifyListeners();
  }

}