import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  static const ID = "ID";
  static const NAME = "NAME";
  static const RATING = "RATING";
  static const IMAGE = "IMAGE";
  static const PRICE = "PRICE";
  static const RESTAURANT_ID = "RESTAURANT_ID";
  static const RESTAURANT = "RESTAURANT";
  static const CATEGORY = "CATEGORY";
  static const FEATURED = "FEATURED";
  static const RATES = "RATES";
  static const DESCRIPTION = "DESCRIPTION"; // Corrected spelling

  String _id = "";
  String _name = "";
  int _restaurantId = 0;
  String _restaurant = "";
  String _category = "";
  String _image = "";
  String _description = ""; // Corrected spelling

  double _rating = 0.0;
  double _price = 0.0;
  int _rates = 0;
  ProductModel();
  bool _featured = false;

  String get id => _id;
  String get name => _name;
  String get description => _description; // Corrected spelling
  String get restaurant => _restaurant;
  int get restaurantId => _restaurantId;
  String get category => _category;
  String get image => _image;
  double get rating => _rating;
  double get price => _price;
  bool get featured => _featured;
  int get rates => _rates;

  // public variable
  bool liked = false;

  Map<String, dynamic> toMap() {
    return {
      ID: _id,
      NAME: _name,
      RATING: _rating,
      IMAGE: _image,
      PRICE: _price,
      RESTAURANT_ID: _restaurantId,
      RESTAURANT: _restaurant,
      CATEGORY: _category,
      FEATURED: _featured,
      RATES: _rates,
      DESCRIPTION: _description,
    };
  }

  ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot.data() is Map) {
      final data = snapshot.data() as Map<String, dynamic>;
      _id = data[ID];
      _image = data[IMAGE];
      _restaurant = data[RESTAURANT];
      _restaurantId = data[RESTAURANT_ID];
      _featured = data[FEATURED];
      _price = data[PRICE];
      _category = data[CATEGORY];
      _rating = data[RATING];
      _rates = data[RATES];
      _name = data[NAME];
      _description = data[DESCRIPTION]; // Corrected spelling
    }
  }
}
