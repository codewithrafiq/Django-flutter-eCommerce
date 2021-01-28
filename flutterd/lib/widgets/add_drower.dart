import 'package:flutter/material.dart';
import 'package:flutterd/screens/favorit_screens.dart';
import 'package:flutterd/screens/home_Screens.dart';
import 'package:flutterd/screens/login_screens.dart';
import 'package:flutterd/screens/order_history_screens.dart';
import 'package:localstorage/localstorage.dart';

class AppDrower extends StatefulWidget {
  @override
  _AppDrowerState createState() => _AppDrowerState();
}

class _AppDrowerState extends State<AppDrower> {
  LocalStorage storage = new LocalStorage('usertoken');

  void _logoutnew() async {
    await storage.clear();
    Navigator.of(context).pushReplacementNamed(LoginScrrens.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("Welcome"),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(HomeScreens.routeName);
            },
            trailing: Icon(
              Icons.home,
              color: Colors.blue,
            ),
            title: Text("Home"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(FalvoritScreens.routeName);
            },
            trailing: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            title: Text("Favorit"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrderScreens.routeName);
            },
            trailing: Icon(
              Icons.history,
              color: Colors.blue,
            ),
            title: Text("Old Orders"),
          ),
          Spacer(),
          ListTile(
            onTap: () {
              _logoutnew();
            },
            trailing: Icon(
              Icons.logout,
              color: Colors.green,
            ),
            title: Text("Logout"),
          ),
        ],
      ),
    );
  }
}
