
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../Models/Products.dart';
import '../Models/cart_item.dart';
import '../providers/app.dart';
import '../providers/product.dart';
import '../providers/user.dart';
import '../widgets/custom_widgets.dart';

class Details extends StatefulWidget {
  final ProductModel product;

  const Details({required this.product});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int quantity = 1;
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final product = Provider.of<ProductProvider>(context);
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // changeScreen(context, CartScreen());
            },
          ),
        ],
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 120,
              backgroundImage: NetworkImage(widget.product.image),
            ),
            SizedBox(
              height: 15,
            ),
            CustomText(
                text: widget.product.name,
                size: 26,
                fontWeight: FontWeight.bold, color:Colors.black,),
            CustomText(
                text: "\$${widget.product.price.round()}",
                color:Colors.black,
                size: 20,
                fontWeight: FontWeight.w400),
            SizedBox(
              height: 10,
            ),
            CustomText(
                color:Colors.black,
                text: "Description", size: 18, fontWeight: FontWeight.w400),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.product.description,
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      icon: Icon(
                        Icons.remove,
                        size: 36,
                      ),
                      onPressed: () {
                        if (quantity != 1) {
                          setState(() {
                            quantity -= 1;
                          });
                        }
                      }),
                ),
                GestureDetector(
                  onTap: () async {
                    ItemModel item = ItemModel(
                      id:"",
                      productId: widget.product.id,
                      name: widget.product.name,
                      image: widget.product.image,
                      price: widget.product.price.round().toDouble(),
                      quantity: quantity.toDouble(),
                    );

                    //app.changeLoading();
                    print("All set loading");
                    //todo:add to the new version
                        await product.addProductToCollection(item);
                    bool value =product.isAdd;
                     if(value){
                       print("Item added to cart");
                       ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(content: Text("Added ro Cart!"))
                       );
                      // user.reloadUserModel();
                      // app.changeLoading();
                       return;
                     } else{
                       print("Item NOT added to cart");

                     }
                      print("lOADING SET TO FALSE");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(28, 12, 28, 12),
                      child: CustomText(
                        text: "Add $quantity To Cart",
                        color: Colors.white,
                        size: 22,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      icon: Icon(
                        Icons.add,
                        size: 36,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        setState(() {
                          quantity += 1;
                        });
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
