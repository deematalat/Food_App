import 'package:flutter/cupertino.dart';

import '../Helpers/rastaurant.dart';
import '../Models/rastaurant.dart';


class RastaurantProvider with ChangeNotifier {
  RastaurantService rastaurantService = RastaurantService();
  List<RestaurantModel> rastaurants = [];
  RestaurantModel? rastaurant; // Initialize with null
  List<RestaurantModel> searchedrastaurant = [];

  RastaurantProvider.initialize() {
    _loadrastaurants();
  }

  _loadrastaurants() async {
    rastaurants = await rastaurantService.getrastaurants();
    notifyListeners();
  }

  loadSingleRastaurant({required String rasid}) async {
    rastaurant = await rastaurantService.getRestaurantById(id: rasid);
    notifyListeners();
  }

  Future search({required String rasname}) async {
    searchedrastaurant =
    await rastaurantService.searchrastaurant(rastaurantname: rasname);
    notifyListeners();
  }
}
