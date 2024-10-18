// import 'package:foodly/model/purchase_card.dart';
import 'package:scoped_model/scoped_model.dart';

// import '../config/constant.dart';
// import '../models/covarntent.dart';
import './user_services.dart';

mixin Services on Model, UserService {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void setIndexBottomNav(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
