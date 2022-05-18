import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AppPageWidget extends StatelessWidget {
  final String title;
  final Widget? leading;
  final bool hideAppBar;
  final bool hideTitle;
  final bool hideAppBarBottomDivider;
  final Widget? appBarContentWidget;
  final Widget? contentBody;
  final bool? centerTitle;
  final Widget? noScrollBody;
  final Widget? customAppBar;
  final Color? bodyBackgroundColor;
  final Widget? fixedBottomToolbar; //固定底部的工具栏
  final bool noPaddingBody;
  final bool isLoading;
  final bool enablePullDown;
  final bool enablePullUp;
  final RefreshController? refreshController;
  final ScrollController? scrollController;
  final VoidCallback? onRefresh;
  final VoidCallback? onLoading;
  final Widget? listHeaderView;
  final Widget? listView;
  final Widget? customEmptyDataView;
  final bool showEmptyDataView;
  final String? emptyDataImageUrl;
  final String? emptyDataText;
  final Widget? actionsWidget;
  final BottomNavigationBar? bottomNavigationBar;

  AppPageWidget({
    required this.title,
    this.leading,
    this.hideAppBar = false,
    this.centerTitle = true,
    this.hideTitle = false,
    this.hideAppBarBottomDivider = true,
    this.appBarContentWidget,
    this.contentBody,
    this.customAppBar,
    this.bodyBackgroundColor,
    this.noScrollBody,
    this.noPaddingBody = false,
    this.isLoading = false,
    this.fixedBottomToolbar,
    this.enablePullDown = false,
    this.enablePullUp = false,
    this.refreshController,
    this.scrollController,
    this.onRefresh,
    this.onLoading,
    this.listHeaderView,
    this.listView,
    this.customEmptyDataView,
    this.showEmptyDataView = false,
    this.emptyDataImageUrl,
    this.emptyDataText,
    this.actionsWidget,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _renderAppBar(),
      body: _renderBody(),
      bottomNavigationBar: this.bottomNavigationBar,
    );
  }

  AppBar? _renderAppBar() {
    if (!this.hideAppBar && this.customAppBar == null) {
      return AppBar(
        //centerTitle: centerTitle,
        leading: this.leading,
        iconTheme: IconThemeData(
          color: Colors.black, //修改颜色
        ),
        title: this.hideTitle == true
            ? null
            : appBarContentWidget ??
                Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Text(
                      this.title,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    )),
        actions: _actions(),
        elevation: this.hideAppBarBottomDivider ? 0 : 0.5,
        backgroundColor: Colors.white,
        titleSpacing: 0,
        automaticallyImplyLeading: appBarContentWidget == null ? true : false,
      );
    }
    return null;
  }

  List<Widget>? _actions() {
    if (this.actionsWidget != null && this.appBarContentWidget == null) {
      return [this.actionsWidget!];
    }
    return null;
  }

  Widget _refreshFooter() {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        return Container(
          height: 55.0,
          child: Center(child: Text("加载中...")),
        );
      },
    );
  }

  Widget _refreshHeader() {
    return ClassicHeader(
      releaseText: '',
      idleText: '',
      completeText: '',
      refreshingText: '',
    );
  }

  Widget _renderBody() {
    if (this.listView != null) {
      if (this.enablePullDown && this.refreshController != null) {
        return Container(
            color: Colors.white,
            padding: EdgeInsets.only(
                left: this.noPaddingBody ? 0 : 12,
                right: this.noPaddingBody ? 0 : 12),
            child: SafeArea(
              child: Container(
                  color: this.bodyBackgroundColor ?? Colors.white,
                  child: Column(
                    children: [
                      _customAppBar(),
                      this.listHeaderView ?? Container(),
                      Expanded(
                        child: Container(
                            child: SmartRefresher(
                          enablePullDown: true,
                          enablePullUp: this.enablePullUp,
                          header: _refreshHeader(),
                          footer: _refreshFooter(),
                          controller: this.refreshController!,
                          onRefresh: this.onRefresh,
                          onLoading: this.onLoading,
                          child: this.showEmptyDataView
                              ? emptyDataView()
                              : this.listView,
                        )),
                      ),
                      this.fixedBottomToolbar ?? Container()
                    ],
                  )),
            ));
      } else {
        return Container(
            color: Colors.white,
            padding: EdgeInsets.only(
                left: this.noPaddingBody ? 0 : 12,
                right: this.noPaddingBody ? 0 : 12),
            child: SafeArea(
              child: Container(
                  color: this.bodyBackgroundColor ?? Colors.white,
                  child: Column(
                    children: [
                      _customAppBar(),
                      Expanded(
                          child: ListView(
                        children: [
                          this.listHeaderView ?? Container(),
                          this.listView!,
                        ],
                      )),
                    ],
                  )),
            ));
      }
    } else {
      if (this.contentBody is PageView) {
        return this.contentBody!;
      } else {
        return Material(
            child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(
              left: this.noPaddingBody ? 0 : 12,
              right: this.noPaddingBody ? 0 : 12),
          width: double.infinity,
          child: SafeArea(
              child: Container(
            color: this.bodyBackgroundColor ?? Colors.white,
            child: Column(
              children: [
                _customAppBar(),
                Expanded(child: Builder(
                  builder: (context) {
                    if (contentBody != null) {
                      return ListView(
                        controller: this.scrollController,
                        children: [
                          this.contentBody!,
                        ],
                      );
                    }
                    if (noScrollBody != null) {
                      return noScrollBody!;
                    }
                    return Container();
                  },
                )),
                this.fixedBottomToolbar ?? Container()
              ],
            ),
          )),
        ));
      }
    }
  }

  Widget _customAppBar() {
    if (this.customAppBar != null) {
      return Column(
        children: [
          Container(
              color: Colors.white,
              height: 44,
              padding: EdgeInsets.only(left: 18, right: 18),
              child: this.customAppBar!),
          this.hideAppBarBottomDivider
              ? Container()
              : Divider(
                  height: 0.5, thickness: 0.5, color: Colors.grey),
        ],
      );
    }
    return Container();
  }

  Widget emptyDataView() {
    if (this.showEmptyDataView) {
      return Container(
        width: double.infinity,
        constraints: BoxConstraints(
          minHeight: 200,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                onTap: this.onRefresh,
                child: this.customEmptyDataView != null
                    ? this.customEmptyDataView
                    : Container(
                        width: double.infinity,
                        height: 350,
                        decoration: this.emptyDataImageUrl == null
                            ? null
                            : BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(this.emptyDataImageUrl!),
                                ),
                              ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                this.emptyDataText ?? "暂无数据",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0XFF939597)),
                              ),
                              SizedBox(height: 50),
                            ]),
                      ))
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
