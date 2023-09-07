import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {

  late String name;
  late String email;
  late String id;
  late String stripeId;
  UserModel();
  UserModel.fromSnapshot(DocumentSnapshot? snapshot) {
    if(snapshot == null) {
      return;
    }
    if(snapshot.data() is Map) {
      final data = snapshot.data() as Map<String, dynamic>;

      name =data['name'] ?? '';
      email = data['email'] ?? '';
      id = data['id'] ?? '';
      stripeId = data['stripeId'] ?? '';
    }
  }

}