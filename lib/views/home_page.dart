import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_demo/core/di/inject_provider.dart';
import 'package:flutter_mvvm_demo/core/di/navigate_service.dart';
import 'package:flutter_mvvm_demo/core/widgets/app_page_widget.dart';
import 'package:flutter_mvvm_demo/core/widgets/banner_widget.dart';
import 'package:flutter_mvvm_demo/view_models/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider<HomeViewModel>(
        create: (context) => HomeViewModel(context),
        child: Consumer<HomeViewModel>(builder: (ctx, state, child) {
          return AppPageWidget(
              title: '首页',
              hideAppBar: true,
              noPaddingBody: true,
              enablePullDown: true,
              refreshController: _refreshController,
              onRefresh: () {
                state.loadData();
                _refreshController.refreshCompleted();
              },
              listView: ListView(
                shrinkWrap: true,
                children: [
                  _bannerView(),
                  _titleView(),
                  _buttonViews(),
                  _textView()
                ],
              ));
        }));
  }

  /// Banners
  Widget _bannerView() {
    return Consumer<HomeViewModel>(builder: (ctx,state,child) {
      return BannerWidget(
        180.0,
        state.getBannerItems(),
        bannerPress: (pos, item) {
          inject<NavigateService>().pushNamed('NewsDetailPage',arguments: {'newsId': '1'});
        },
      );
    });
  }

  /// 标题部分
  Widget _titleView() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Oeschinen Lake Campground',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Kandersteg, Switzerland',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          _favoriteView()
        ],
      ),
    );
  }

  Widget _favoriteView() {
    return Consumer<HomeViewModel>(builder: (ctx,state,child) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
              padding: EdgeInsets.all(0),
              child: IconButton(
                padding: EdgeInsets.all(0),
                alignment: Alignment.centerRight,
                icon: (state.isLiked? Icon(Icons.star) : Icon(Icons.star_border)),
                color: Colors.red[500],
                onPressed: state.toggleLike,
              )
          ),
          Container(
            child: Text(state.isLiked.toString()),
          )
        ],
      );
    });
  }

  Widget _buttonViews() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButton(Colors.blueAccent, Icons.call, 'Call'),
          _buildButton(Colors.blueAccent, Icons.near_me, 'Route'),
          _buildButton(Colors.blueAccent, Icons.share, 'Share')
        ],
      ),
    );
  }

  Widget _textView() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
            'Alps. Situated 1,578 meters above sea level, it is one of the '
            'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
            'half-hour walk through pastures and pine forest, leads you to the '
            'lake, which warms to 20 degrees Celsius in the summer. Activities '
            'enjoyed here include rowing, and riding the summer toboggan run.',
        softWrap: true,
      ),
    );
  }

  InkWell _buildButton(Color color, IconData icon, String title) {
    return InkWell(
      onTap: (){
        inject<NavigateService>().pushNamed('ActivityList');
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: color
              ),
            ),
          )
        ],
      ),
    );
  }

}