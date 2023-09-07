import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../Helpers/user_services.dart';
import '../Models/users.dart';


enum Status { uninitialized, unauthenticated, authenticating, authenticated }

class UserProvider with ChangeNotifier {
  FirebaseAuth _auth;
  Status _status = Status.uninitialized;
  UserServices _userServices = new UserServices();
  UserModel _userModel = UserModel() ; // Initialize with an empty user model
  User? _user; // Initialize as nullable

  final formkey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Status get status => _status;
  UserModel get userModel => _userModel;
  User? get user => _user; // User can be nullable

  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen((User? firebaseUser) async {
      if (firebaseUser == null) {
        _status = Status.unauthenticated;
      } else {
        _user = firebaseUser;
        _status = Status.authenticated;
        _userModel = await _userServices.getUserbyid(firebaseUser.uid);
      }  if (_auth.currentUser!=null){
        _status = Status.authenticated;
      }
      notifyListeners();
    });
  }

  Future<void> _onStateChanged(User firebaseuser) async {
    if (firebaseuser == null) {
      _status = Status.uninitialized;
    } else {
      _user = firebaseuser;
      _status = Status.authenticated;
      _userModel = await _userServices.getUserbyid(firebaseuser.uid);
    }
    notifyListeners();
  }

  Future<bool> SignIn() async {
    try {
      _status = Status.authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      return true;
    } catch (e) {
      _status = Status.unauthenticated;
      notifyListeners();
      print("error ${e.toString}");
      return false;
    }
  }

  Future<bool> SignUp() async {
    try {
      _status = Status.authenticating;
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim())
          .then((user) {
        Map<String, dynamic> values = {
          "name": name.text,
          "email": email.text,
          "id": user.user!.uid,
          "likeFoods": [],
          "likedRastaurants": []
        };
        _userServices.create_user(values);
      });
      return true;
    } catch (e) {
      _status = Status.unauthenticated;
      notifyListeners();
      print("error ${e.toString}");
      return false;
    }
  }

  Future<void> SignOut() async {
    _auth.signOut();
    _status = Status.unauthenticated;
    notifyListeners();
    Future.delayed(Duration.zero);
  }

  void CleanControllers() {
    name.text = "";
    email.text = "";
    password.text = "";
  }
}
