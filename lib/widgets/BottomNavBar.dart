import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Helpers/screen_navigation.dart';
import '../Screens/Home.dart';
import '../Screens/loginScreen.dart';
import '../Screens/profilScreen.dart';
import '../Screens/shoppingBag.dart';
import '../providers/user.dart';

class BottomNavBar extends StatefulWidget {
  int active;
  BottomNavBar({required this.active});
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return CurvedNavigationBar(
      height: 50,
      color: Colors.red,
      backgroundColor: Colors.white,
      animationDuration: Duration(milliseconds: 350),
      animationCurve: Curves.easeInOutExpo,
      index: widget.active,
      items: <Widget>[
        Icon(Icons.logout, size: 30, color: Colors.black),
        Icon(Icons.account_box, size: 30, color: Colors.black),
        Icon(Icons.home, size: 30, color: Colors.black),
        Icon(Icons.shop, size: 30, color: Colors.black),
        Icon(Icons.settings, size: 30, color: Colors.black),
      ],
      onTap: (index) {
        if (index == widget.active) return;
        if(index == 0){
          user.SignOut();
          ChangeScreenReplacement(context, LoginScreen());
        }
        if(index == 1) {
          ChangeScreen(context,ProfilScreen());
          setState(() {});
        }
        if (index == 3) {
          ChangeScreen(context, ShoppingBag());
          setState(() {});
        }
        if (index == 2) {
          ChangeScreen(context, Home());
          //todo:add to new version
          setState(() {});
        }
      },
    );
  }
}
