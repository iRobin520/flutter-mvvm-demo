import 'package:flutter_mvvm_demo/core/network/http_client.dart';
import 'package:flutter_mvvm_demo/models/banner_entity.dart';
import 'package:flutter_mvvm_demo/models/news_entity.dart';
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements HttpClient {

  Future<List<BannerEntity>?> getBanners() async {
    BannerEntity item = BannerEntity();
    item.title = '海天一色';
    item.imageUrl = 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.jj20.com%2Fup%2Fallimg%2F811%2F091214203241%2F140912203241-2-1200.jpg&refer=http%3A%2F%2Fimg.jj20.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1654071337&t=7d5b3bde3439c1172a248bd9e2ae52c3';
    item.imageLink = 'https://www.baidu.com/';
    return [item, item, item];
  }

  Future<NewsEntity> getNewsDetail(String newsId) async {
    NewsEntity item = NewsEntity();
    item.id = '1';
    item.title = 'news title';
    item.content = 'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
        'Alps. Situated 1,578 meters above sea level, it is one of the '
        'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
        'half-hour walk through pastures and pine forest, leads you to the '
        'lake, which warms to 20 degrees Celsius in the summer. Activities '
        'enjoyed here include rowing, and riding the summer toboggan run.';
    item.publishDate = '2022-5-3';
    return item;
  }

}