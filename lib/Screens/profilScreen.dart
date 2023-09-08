

import 'package:flutter/material.dart';
import 'package:food_final/Screens/Home.dart';
import 'package:food_final/Screens/shoppingBag.dart';
import 'package:provider/provider.dart';
import '../Helpers/screen_navigation.dart';
import '../providers/user.dart';
import 'loginScreen.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title:Text("Profile",style: TextStyle(
          fontSize: 24,fontWeight: FontWeight.bold,color: Colors.black
          ),),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body:
      SafeArea(
          child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        SizedBox(height:30,),
        Padding(padding: EdgeInsets.all(40) ,
       child: Column(
          children: [
       Card(elevation:3,
         shape: const RoundedRectangleBorder(
             borderRadius: BorderRadius.all(Radius.circular(20.0))),
         child:    Container(
           height: 200,
           width:double.infinity,
           child:Stack(
             clipBehavior:Clip.none,
           children: <Widget>[
             Positioned(
                 bottom:130 ,
                 right:120,
                 child:
                 CircleAvatar(
                   radius:50,
                   child:Image.network("https://t4.ftcdn.net/jpg/02/29/75/83/240_F_229758328_7x8jwCwjtBMmC6rgFzLFhZoEpLobB6L8.jpg",fit:BoxFit.cover,),
                 )),
             Positioned(
               bottom:80 ,
               left:80,
               child: Text(user.userModel.name,style: TextStyle(
                 fontSize: 16,fontWeight: FontWeight.bold
               ),),),
              Positioned(
             bottom:60 ,
             right:90,
             child:   Text(user.userModel.email!),)
           ]
       ),
         ),
       ),

            ListTile(
              title: Text(
                "Home",
                style: TextStyle(fontSize: 20),
              ),
              leading: Icon(
                Icons.home,
                size: 35,
              ),
              onTap: () => {
                ChangeScreen(
                    context,
                    Home())
              },
            ),
            ListTile(
              title: Text(
                "Food I like",
                style: TextStyle(fontSize: 20),
              ),
              leading: Icon(
                Icons.food_bank_outlined,
                size: 35,
              ),
              onTap: () => {
                ChangeScreen(
                    context,
                    ShoppingBag()
                )
              },
            ),
            ListTile(
              title: Text(
                "Cart",
                style: TextStyle(fontSize: 20),
              ),
              leading: Icon(
                Icons.shopping_cart,
                size: 35,
              ),
              onTap: () => {
                Navigator.pop(context),
                ChangeScreen(context, ShoppingBag())
              },
            ),
            ListTile(
              title: Text(
                "My orders",
                style: TextStyle(fontSize: 20),
              ),
              leading: Icon(
                Icons.bookmark_border,
                size: 35,
              ),
              onTap: () => {

              },
            ),
            ListTile(
              title: Text(
                "Settings",
                style: TextStyle(fontSize: 20),
              ),
              leading: Icon(
                Icons.settings,
                size: 35,
              ),
              onTap: () => {},
            ),
            ListTile(
              onTap: () {
                user.SignOut();
                ChangeScreenReplacement(context, LoginScreen());
              },
              leading: Icon(
                Icons.exit_to_app,
                size: 35,
              ),
              title: Text(
                "Logout",
                style: TextStyle(fontSize: 20),
              ),
            ),

          ],
        ),)
      ],
    ),
    ));
  }
}


