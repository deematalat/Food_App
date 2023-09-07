import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Helpers/screen_navigation.dart';
import '../Models/Products.dart';
import '../Screens/rastaurant.dart';
import '../providers/product.dart';
import '../providers/rastaurant.dart';
import 'custom_widgets.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel product;

  const ProductWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final restaurantProvider = Provider.of<RastaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 10),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300,
                  offset: Offset(-2, -1),
                  blurRadius: 5),
            ]),
//            height: 160,
        child: Row(
          children: <Widget>[
            Container(
              width: 140,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                child: Image.network(
                  product.image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                           product.name,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    offset: Offset(1, 1),
                                    blurRadius: 4),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.red,
                              size: 18,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Row(
                      children: <Widget>[
                        CustomText(
                          text: "from: ",
                          color: Colors.grey,
                          fontWeight: FontWeight.w300,
                          size: 14,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await productProvider.loadproductsbyRastaurants(id: product.restaurantId);
                            await restaurantProvider.loadSingleRastaurant(
                                rasid: product.restaurantId.toString());

                            // Check if restaurantProvider.rastaurant is not null before passing it
                            if (restaurantProvider.rastaurant != null) {
                              ChangeScreen(
                                context,
                                RestaurantScreen(restaurantModel: restaurantProvider.rastaurant!),
                              );
                            } else {
                              // Handle the case where restaurantProvider.rastaurant is null
                              // You can display an error message or take appropriate action here
                            }
                          },
                          child: CustomText(
                            text: product.restaurant,
                            color: Colors.red,
                            fontWeight: FontWeight.w300,
                            size: 14,
                          ),
                        ),

                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding:  EdgeInsets.only(left: 8.0),
                            child: CustomText(
                              text: product.rating.round().toString(),
                              fontWeight: FontWeight.w300,
                              color: Colors.grey,
                              size: 14.0,
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.red,
                            size: 16,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.red,
                            size: 16,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.red,
                            size: 16,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.grey,
                            size: 16,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CustomText(
                          text: "\$${product.price.round()}",
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          size: 14.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
