import 'package:flutter/widgets.dart';
import 'package:flutter_mvvm_demo/core/widgets/app_loading_widget.dart';

///所有viewModel的父类，提供一些公共功能
abstract class BaseViewModel extends ChangeNotifier {

  bool _isInitialized = true;
  late BuildContext context;

  bool get isInitialized=>_isInitialized;

  BaseViewModel(BuildContext context) {
    this.context = context;
    this.init();
  }

  void init() {
    if (_isInitialized) {
      _isInitialized = false;
      initialize();
    }
  }

  ///获取数据
  @protected
  Future loadData();

  ///初始化
  void initialize() {
    Future.delayed(Duration(milliseconds: 100), () {
      var future = loadData();
      if (future != null) {
        AppProgressDialog.show();
        future.then((value) {
          AppProgressDialog.dismiss();
        });
        future.catchError((error) {
          AppProgressDialog.dismiss();
        });
      }
    });
  }

  ///资源释放
  void dispose();
}