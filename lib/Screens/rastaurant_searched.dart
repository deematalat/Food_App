import 'package:flutter/material.dart';
import 'package:food_final/Screens/rastaurant.dart';
import 'package:provider/provider.dart';

import '../Helpers/screen_navigation.dart';
import '../providers/product.dart';
import '../providers/rastaurant.dart';
import '../widgets/custom_widgets.dart';
import '../widgets/rastaurants.dart';

class RastaurantSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rastaurantprovider = Provider.of<RastaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
           "Rastaurants",

        ),
        elevation: 0.0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {})
        ],
      ),
      body: rastaurantprovider.searchedrastaurant.length < 1
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomText(
                      text: "No Rastaurants Found",
                      color: Colors.grey,
                      fontWeight: FontWeight.w300,
                      size: 22,
                    ),
                  ],
                )
              ],
            )
          : ListView.builder(
              itemCount: rastaurantprovider.searchedrastaurant.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () async {
                      await productProvider.loadproductsbyRastaurants(
                          id: rastaurantprovider.searchedrastaurant[index].id);
                      ChangeScreen(
                          context,
                          RestaurantScreen(
                              restaurantModel: rastaurantprovider
                                  .searchedrastaurant[index]));
                    },
                    child: Rastaurantwidget(
                        rastaurant:
                            rastaurantprovider.searchedrastaurant[index]));
              }),
    );
  }
}
