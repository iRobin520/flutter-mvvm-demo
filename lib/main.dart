import 'package:flutter/material.dart';
import 'package:flutter_mvvm_demo/core/di/inject_provider.dart';
import 'package:flutter_mvvm_demo/core/di/navigate_service.dart';
import 'package:flutter_mvvm_demo/core/router.dart' as router;
import 'views/home_page.dart';
import 'views/more_page.dart';

void main() {
  setupInjection(); //模块注入
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: inject<NavigateService>().key,
      onGenerateRoute: router.generateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        highlightColor: Color.fromRGBO(0, 0, 0, 0),
        splashColor: Color.fromRGBO(0, 0, 0, 0),
      ),
      home: MyTabs(),
    );
  }
}

class MyTabs extends StatefulWidget {
  @override
  _MyTabsState createState() => _MyTabsState();
}

class _MyTabsState extends State<MyTabs> with AutomaticKeepAliveClientMixin {

  PageController? _pageController;
  List<Widget>? _pageViews;
  int _currentIndex = 0;

  @override
  bool get wantKeepAlive => true;
  
  @override
  void initState() {
    _pageController = PageController(initialPage: _currentIndex, keepPage: true);
    _pageViews = [HomePage(), MorePage()];

    super.initState();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
            title: Text('Hello world!'),
            backgroundColor: Colors.deepOrange
        ),
        body: PageView(
          controller: _pageController,
          children: _pageViews!,
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
              _pageController!.jumpToPage(_currentIndex);
            },
            items: [
              BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
              BottomNavigationBarItem(label: 'More', icon: Icon(Icons.more))
            ]
        )
    );
  }
}
