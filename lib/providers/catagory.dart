import 'package:flutter/cupertino.dart';

import '../Helpers/catagory.dart';
import '../Models/catagoryModel.dart';


class CatagoryProvider with ChangeNotifier {
  CatagoryService catagoryService = CatagoryService();
  List<CategoryModel> catagories = [];

  CatagoryProvider.initialize() {
    _loadcatagories();
  }

  _loadcatagories() async {
    catagories = await catagoryService.getcatagories();
    notifyListeners();
  }
}
