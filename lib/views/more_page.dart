import 'package:flutter/material.dart';

class MorePage extends StatefulWidget {

  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {

  @override
  Widget build(BuildContext context) {

    Widget ratingSection = Container(
      padding: EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, color: Colors.black),
              Icon(Icons.star, color: Colors.black),
              Icon(Icons.star, color: Colors.black),
              Icon(Icons.star, color: Colors.black),
              Icon(Icons.star, color: Colors.black),
            ],
          ),
          Text(
            '170 Reviews',
            style: new TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontFamily: 'Roboto',
              letterSpacing: 0.5,
              fontSize: 20.0,
            ),
          )
        ],
      ),
    );

    var descTextStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w800,
      fontFamily: 'Roboto',
      letterSpacing: 0.5,
      fontSize: 18.0,
      height: 2.0
    );

    var iconList = DefaultTextStyle(
        style: descTextStyle,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Icon(Icons.kitchen, color: Colors.green[500]),
                  Text('PREP:'),
                  Text('25 min')
                ],
              ),
              Column(
                children: [
                  Icon(Icons.timer, color: Colors.green[500]),
                  Text('COOK:'),
                  Text('1 hour')
                ],
              ),
              Column(
                children: [
                  Icon(Icons.restaurant, color: Colors.green[500]),
                  Text('FOODS:'),
                  Text('4-6')
                ],
              ),
            ],
          ),
        )
    );

    Widget mainContent = Container(
      child: ListView(
        padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Image.asset('images/cake.jpg'),
          ),
          Text('Strawberry Pavlova', style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32.0,
              color: Colors.grey[800]
          )),
          Text('Pavlova is a meringue-based desert named after the Russian ballerine Anna Pavlova. Pavlova features a crisp crust and soft, light inside, topped with fruit and whipped cream.', style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 20.0,
              color: Colors.grey[500]
          )),
          ratingSection,
          iconList
        ],
      ),
    );

    return Container(
      child: Center(
        child: mainContent,
      ),
    );
  }
}