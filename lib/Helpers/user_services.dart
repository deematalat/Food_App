import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/users.dart';


class UserServices {
  String usercollection = 'Users';
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  void create_user(Map<String, dynamic> values) {
    _firestore.collection(usercollection).doc(values["id"]).set(values);
  }

  void update_user(Map<String, dynamic> values) {
    _firestore.collection(usercollection).doc(values['id']).update(values);
  }

  Future<UserModel> getUserbyid(String id) =>
      _firestore.collection(usercollection).doc(id).get().then((doc) {
        return UserModel.fromSnapshot(doc);
      });


}
