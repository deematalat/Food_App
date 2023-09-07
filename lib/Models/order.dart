import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  static const ID = "id";
  static const DESCRIPTION = "description";
  static const CART = "cart";
  static const USER_ID = "userId";
  static const TOTAL = "total";
  static const STATUS = "status";
  static const CREATED_AT = "createdAt";
  static const RESTAURANT_ID = "restaurantId";

  String _id = "";
  String _restaurantId = "";
  String _description = "";
  String _userId = "";
  String _status = "";
  int _createdAt = 0;
  int _total = 0;
  List _cart = []; // Initialize as an empty list

  // getters
  String get id => _id;
  String get restaurantId => _restaurantId;
  String get description => _description;
  String get userId => _userId;
  String get status => _status;
  int get total => _total;
  int get createdAt => _createdAt;

  // public variable
  List get cart => _cart;

  OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      _id = data[ID] ?? "";
      _description = data[DESCRIPTION] ?? "";
      _total = data[TOTAL] ?? 0;
      _status = data[STATUS] ?? "";
      _userId = data[USER_ID] ?? "";
      _createdAt = data[CREATED_AT] ?? 0;
      _restaurantId = data[RESTAURANT_ID] ?? "";
      _cart = data[CART] ?? [];
    }
  }
}

