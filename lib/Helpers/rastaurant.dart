import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/rastaurant.dart';


class RastaurantService {
  String rastaurantcollection = "restaurants";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<RestaurantModel>> getrastaurants() async =>
      _firestore.collection(rastaurantcollection).get().then((result) {
        List<RestaurantModel> rastaurants = [];
        for (DocumentSnapshot rastaurant in result.docs) {
          rastaurants.add(RestaurantModel.fromSnapshot(rastaurant));
        }
        return rastaurants;
      });

  Future<RestaurantModel> getRestaurantById({required String id}) =>
      _firestore.collection(rastaurantcollection).doc(id).get().then((doc) {
        return RestaurantModel.fromSnapshot(doc);
      });

  Future<List<RestaurantModel>> searchrastaurant({required String rastaurantname}) {
    String searchname =
        rastaurantname[0].toUpperCase() + rastaurantname.substring(1);
    return _firestore
        .collection(rastaurantcollection)
        .orderBy("name")
        .startAt([searchname])
        .endAt([searchname + 'uf8ff'])
        .get()
        .then((result) {
          List<RestaurantModel> rastaurants = [];
          for (DocumentSnapshot rastaurant in result.docs) {
            rastaurants.add(RestaurantModel.fromSnapshot(rastaurant));
          }
          return rastaurants;
        });
  }
}
