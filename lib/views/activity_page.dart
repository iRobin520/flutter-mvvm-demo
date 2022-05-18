import 'package:flutter/material.dart';
import 'package:flutter_mvvm_demo/core/widgets/app_page_widget.dart';
import 'package:flutter_mvvm_demo/models/activity_entity.dart';
import 'package:flutter_mvvm_demo/view_models/activity_view_model.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ActivityPage extends StatefulWidget {
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ActivityViewModel>(
      create: (context) => ActivityViewModel(context),
      child: Consumer<ActivityViewModel>(builder: (ctx, state, child) {
        return AppPageWidget(
          title: '活动',
          enablePullDown: true,
          refreshController: _refreshController,
          onRefresh: () {
            state.loadData();
            _refreshController.refreshCompleted();
          },
          listView: ListView.builder(
              itemCount: state.activities?.length ?? 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = state.activities![index];
                return _buildItem(item);
              }),
        );
      }),
    );
  }

  Widget _buildItem(ActivityEntity item) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(item.url, width: 300, height: 300, fit: BoxFit.fill)
          ),
          SizedBox(height: 10),
          Text(
            '限量 ${item.totalChance}份',
            style: TextStyle(color: Colors.black, fontSize: 12),
          ),
          SizedBox(height: 10),
          Text(
            item.name,
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
        ],
      ),
    );
  }

}