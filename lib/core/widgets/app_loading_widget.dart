import 'package:flutter/material.dart';
import 'package:flutter_mvvm_demo/core/di/inject_provider.dart';
import 'package:flutter_mvvm_demo/core/di/navigate_service.dart';

/// 加载进度条

class AppProgressDialog {
  static dynamic context = inject<NavigateService>().navigator?.overlay?.context;

  static void show() {
    final ThemeData theme = Theme.of(context);
    showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
        final Widget pageChild = AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              //ImageUtil.loadImage('images/pc/common/common_loading.gif', height: 100.w)
              CircularProgressIndicator(
                color: Colors.indigo,
              )
            ],
          ),
        );
        return SafeArea(
          child: Builder(builder: (BuildContext context) {
            return Theme(data: theme, child: pageChild);
          }),
        );
      },
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black12,
      transitionDuration: const Duration(milliseconds: 150),
      transitionBuilder: _buildMaterialDialogTransitions,
    );
  }

 static Widget _buildMaterialDialogTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: child,
    );
  }

 static void dismiss() {
    Navigator.pop(context);
  }
}
