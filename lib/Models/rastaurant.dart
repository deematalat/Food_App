import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantModel {

  late int id;
  late String name;
  late String image;
  late double avgPrice;

  RestaurantModel({required this.id,required this.name,required this.image,required
  this.avgPrice,required this.popular,required this.rates,required this.rating});

  late double rating;
  late bool popular;
  late int rates;

  RestaurantModel.fromSnapshot(DocumentSnapshot snapshot) {

    // Ensure snapshot data is a Map
    if(snapshot.data() is Map) {
      final data = snapshot.data() as Map<String, dynamic>;

      // Access data using [] operator
      id = data['id'] ?? 0;
      name = data['name'] ?? '';
      image = data['image'] ?? '';
      avgPrice = data['avgPrice']?.toDouble() ?? 0.0;
      rating = data['rating']?.toDouble() ?? 0.0;
      popular = data['popular'] ?? false;
      rates = data['rates'] ?? 0;

    }

  }

}