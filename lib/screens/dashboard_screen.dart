import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'profile.dart' as first;
import 'sell.dart' as second;
import 'buy.dart' as third;

class DashboardScreen extends StatefulWidget {
  static const String id = 'dashboard_screen';
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  TabController controller;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: GradientAppBar(
          title: Text('Book Sell'),
          gradient: LinearGradient(colors: [Colors.red, Colors.deepPurpleAccent]),
          bottom: TabBar(tabs: <Widget>[
            Tab(
              icon: Icon(Icons.person),
              text: 'Profile',
            ),
            Tab(
              icon: Icon(Icons.attach_money),
              text: 'Sell',
            ),
            Tab(
              icon: Icon(Icons.add_shopping_cart),
              text: 'Buy',
            )
          ]),
        ),
        body: TabBarView(
          controller: controller,
          children: [
            first.Profile(),
            second.Sell(),
            third.Buy()
          ],
        ),
      ),
    );
  }
}