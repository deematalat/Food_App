import 'package:flutter/cupertino.dart';


import '../Helpers/products.dart';
import '../Models/Products.dart';
import '../Models/cart_item.dart';

class ProductProvider with ChangeNotifier {
  ProductService productService = ProductService();
  List<ProductModel> products = [];
  List<ItemModel> productsCards = [];
  List<ItemModel> productsBags = [];
  List<ProductModel> productsByCategory = [];
  List<ProductModel> productsbyRastaurants = [];
  List<ProductModel> productsSearched = [];

  ProductProvider.initialize() {
    _loadrproducts();
    search(proname: "b");
  }

  Future loadProductsByCategory({required String categoryName}) async {
    productsByCategory =
        await productService.getproductsofparticularcatagory(categoryName);
    notifyListeners();
  }

  Future loadproductsbyRastaurants({required int id}) async {
    productsbyRastaurants = await productService.getproductsbyRastaurants(id);
    notifyListeners();
  }

  _loadrproducts() async {
    products = await productService.getproducts();
    notifyListeners();
  }

  Future search({required String proname}) async {
    productsSearched =
        await productService.searchproducts(productname: proname);
    notifyListeners();
  }
  Future getcardproducts() async{
    productsCards =
    await productService.getcardproducts();
    notifyListeners();
  }
  Future addProductToCollection(ItemModel product)async {
    productsBags =
        await productService.addProductToCollection(product);
    notifyListeners();
  }
  Future deleteProductFromCollection(String productId) async{
    await productService.deleteProductFromCollection(productId);
  }
}
