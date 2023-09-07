import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../widgets/BottomNavBar.dart';
import '../widgets/custom_widgets.dart';

class ShoppingBag extends StatefulWidget {
  @override
  _ShoppingBagState createState() => _ShoppingBagState();
}

class _ShoppingBagState extends State<ShoppingBag> {

  @override
  Widget build(BuildContext context) {
      Provider.of<ProductProvider>(context).getcardproducts();
     final product = Provider.of<ProductProvider>(context,listen:false).productsCards;
    print(product);
    return Scaffold(
      bottomNavigationBar: BottomNavBar(active: 3),
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: CustomText(
            text: "Shopping Bag",
            size: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0, right: 4),
                    child: Image.asset(
                      'images/shop.jpg',
                      height: 30,
                      width: 30,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(2, 3),
                              blurRadius: 3)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(1),
                      child: CustomText(
                        size: 14,
                        text: "${product.length}",
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
      body: ListView.builder(
          itemCount: product.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 16, 8, 8),
                child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(2, 6),
                            blurRadius: 10,
                          )
                        ]),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.network(
                          '${product[index].image}',
                          height: 110,
                          width: 110,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: product[index].name + '\n',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 24)),
                              TextSpan(
                                  text: ' \$' + product[index].price.round().toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))
                            ]),
                          ),
                        ),
                        SizedBox(
                          width: 70,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            size: 30,
                          ),
                          onPressed: () async {

                              await Provider.of<ProductProvider>(context, listen: false)
                                  .deleteProductFromCollection(product[index].id);

                          },
                        )

                      ],
                    )));
          }),
    );
  }
}
