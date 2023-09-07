import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import '../Helpers/screen_navigation.dart';
import '../Screens/details.dart';
import '../providers/product.dart';
import 'Loading.dart';

class Featured extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Container(
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productProvider.products.length,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                ChangeScreen(
                    context,
                    Details(
                      product: productProvider.products[index],
                    ));
              },
              child: Container(
                height: 240,
                width: 200,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade300,
                      offset: Offset(15, 5),
                      blurRadius: 30)
                ]),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Loading(),
                            ),
                          ),
                          Center(
                            child: FadeInImage.memoryNetwork(
                              height: 170,
                              width: 170,
                              placeholder: kTransparentImage,
                              image: productProvider.products[index].image,
                            ),
                          )
                          // Image.network(
                          //   catagoryProvider.catagories[index].image,
                          //   width: 150,
                          //   height: 100,
                          // ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:  Text(
                             productProvider.products[index].name,
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
                                      color: Colors.grey.shade600,
                                      offset: Offset(1, 1),
                                      blurRadius: 4)
                                ]),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              // child: productList[index].wishlist
                              //     ? Icon(
                              //         Icons.favorite,
                              //         color: Colors.red,
                              //         size: 18,
                              //       )
                              //     : Icon(
                              //         Icons.favorite_border,
                              //         color: Colors.red,
                              //         size: 18,
                              //       )
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                 productProvider.products[index].rating.round()
                                    .toString(),
                              ),
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.red,
                              size: 18,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.red,
                              size: 18,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.red,
                              size: 18,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.red,
                              size: 18,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.grey,
                              size: 18,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                             "\$${productProvider.products[index].price.round()}",
                            style: TextStyle(
                              fontWeight:
                              FontWeight.bold,),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
