import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/Products.dart';
import '../Models/cart_item.dart';

class ProductService {

  String productcollection = "products";

  String bagscollection = "bags";

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ProductModel>> getproducts() async =>
      _firestore.collection(productcollection).get().then((result) {
        List<ProductModel> products = [];
        for (DocumentSnapshot product in result.docs) {
          products.add(ProductModel.fromSnapshot(product));
        }
        return products;
      });

  Future<List<ProductModel>> getproductsbyRastaurants(int id) async =>
      _firestore
          .collection(productcollection)
          .where("RESTAURANT_ID", isEqualTo: id)
          .get()
          .then((result) {
        List<ProductModel> products = [];
        for (DocumentSnapshot product in result.docs) {
          products.add(ProductModel.fromSnapshot(product));
        }
        return products;
      });

  Future<List<ProductModel>> getproductsofparticularcatagory(
          String catagoryname) async =>
      _firestore
          .collection(productcollection)
          .where("CATEGORY", isEqualTo: catagoryname)
          .get()
          .then((result) {
        List<ProductModel> products = [];
        for (DocumentSnapshot product in result.docs) {
          products.add(ProductModel.fromSnapshot(product));
        }
        return products;
      });

  Future<List<ProductModel>> searchproducts({required String productname}) {
    String searchname = productname[0].toUpperCase() + productname.substring(1);
    return _firestore
        .collection(productcollection)
        .orderBy("NAME")
        .startAt([searchname])
        .endAt([searchname + 'uf8ff'])
        .get()
        .then((result) {
          List<ProductModel> products = [];
          for (DocumentSnapshot product in result.docs) {
            products.add(ProductModel.fromSnapshot(product));
          }

          return products;
        });
  }

  Future<List<ItemModel>> getcardproducts() async {
    try {
      final result = await _firestore.collection(bagscollection).get();
      List<ItemModel> items = [];
      for (DocumentSnapshot product in result.docs) {
        // Check if the data is not null before using it
        if (product.data() != null) {
          items.add(ItemModel.fromSnapshot(product));
        }
      }
      print(items);
      return items;
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }


  Future deleteProductFromCollection(String productId) async {
    try {
      await FirebaseFirestore.instance
          .collection(bagscollection)
          .doc(productId)
          .delete();
      print("Product deleted successfully");
    } catch (e) {
      print("Error deleting product: $e");
    }
  }



  Future addProductToCollection(ItemModel product) async {
    try {
      DocumentReference docRef = await FirebaseFirestore.instance
          .collection(bagscollection)
          .add(product.toMap());
      String id = docRef.id;
      await docRef.update({'id': id});
      print("Product added successfully with ID: ${docRef.id}");
    } catch (e) {
      print("Error adding product: $e");
    }
  }



}
