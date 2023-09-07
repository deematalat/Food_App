import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  static const ID = "id";
  static const PRODUCT_ID = "productId";
  static const NAME = "name";
  static const PRICE = "price";
  static const IMAGE = "image";
  static const QUANTITY = "quantity";

  String id = "";
  String productId = "";
  String name = "";
  String image = "";
  double price = 0.0;
  double quantity = 0.0;

  ItemModel({
    required this.quantity,required this.id,required this.image,required this.price,required this.name,required this.productId
});
  Map<String, dynamic> toMap() {
    return {
      ID: id,
      NAME: name,
      IMAGE: image,
      PRICE: price,
      PRODUCT_ID:productId,
      PRICE:price
    };
  }
  ItemModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    if (data != null) {
      id = snapshot.id; // Firestore document ID
      productId = data[PRODUCT_ID] ?? "";
      name = data[NAME] ?? "";
      image = data[IMAGE] ?? "";
      price = data[PRICE] ?? 0.0;
      quantity = data[QUANTITY] ?? 0.0;
    }
  }

}
