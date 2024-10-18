// import 'package:foodly/model/member.dart';
// import 'package:foodly/model/purchase_card.dart';
import 'package:quizzie_thunder/model/category.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';

import '../utils/constant.dart';
// import '../models/content.dart';
import './user_services.dart';

mixin CategoryService on Model, UserService {
  List<Category> _categories = [];
  List<Category> get categories => _categories;

  bool _isLoadingCategory = false;
  bool get isLoadingCategory => _isLoadingCategory;

  Future<dynamic> fetchAllCategories() async {
    var _categoryData;

    _isLoadingCategory = true;
    notifyListeners();

    var dio = Dio();
    dio.options
      ..baseUrl = Constant.baseUrl
      // ..connectTimeout = 10000 //5s
      // ..receiveTimeout = 10000
      ..validateStatus = (int? status) {
        return status! > 0;
      }
      ..queryParameters = {"token": token}
      ..headers = {
        HttpHeaders.userAgentHeader: 'dio',
        // HttpHeaders.authorizationHeader: 'Bearer $token',
      };

    List<Category> _fetchedCategories = [];

    try {
      var responseData = await dio.get(
        Constant.category,
        // data: _data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      print("url: ${Constant.category}");
      print("RESPONSE GET ALL CATEGORIES: $responseData");

      _categoryData = responseData.data;

      if (responseData.data['data'] != null) {
        for (var category in responseData.data['data']) {
          //
          _fetchedCategories.add(Category.fromJson(category));
          print(
              "RESPONSE GET ALL CATEGORIES Length: ${_fetchedCategories.length}");
        }
      } else {
        print(
            "FETCH GET ALL CATEGORIES Error: ${responseData.data['message']}");
      }
    } catch (e) {
      print(e);
    }

    _categories = _fetchedCategories;

    _isLoadingCategory = false;
    notifyListeners();

    return _categoryData;
  }

  // Future<Map> addOrRemoveMember(dynamic userId) async {
  //   var _responseData;
  //   var dio = Dio();
  //   //
  //   dio.options
  //     ..baseUrl = Constant.baseUrl
  //     // ..connectTimeout = 10000 //5s
  //     // ..receiveTimeout = 10000
  //     ..validateStatus = (int? status) {
  //       return status! > 0;
  //     }
  //     ..headers = {
  //       HttpHeaders.userAgentHeader: 'dio',
  //       HttpHeaders.authorizationHeader: 'Bearer $token'
  //     };

  //   _isLoadingMember = true;
  //   notifyListeners();

  //   try {
  //     var responseData = await dio.delete(
  //       "${Constant.staffOwner}/$userId",
  //       options: Options(
  //         contentType: Headers.formUrlEncodedContentType,
  //       ),
  //     );

  //     print("${Constant.staffOwner}/$userId");

  //     print("RESPONSE ADD OR REMOVE MEMBER: $responseData");

  //     _responseData = responseData.data;

  //     if (responseData.data['data'] != null) {
  //       //
  //       print("Response success add or remove member ${responseData.data}");
  //     } else {
  //       //
  //       print("Response error add or remove member ${responseData.data}");
  //     }
  //   } catch (e) {
  //     print("catch $e");
  //   }

  //   _isLoadingMember = false;
  //   notifyListeners();

  //   return _responseData;
  // }

  // Future<Map> addMemberByEmail(Map data) async {
  //   var _responseData;
  //   var dio = Dio();
  //   //
  //   dio.options
  //     ..baseUrl = Constant.baseUrl
  //     // ..connectTimeout = 10000 //5s
  //     // ..receiveTimeout = 10000
  //     ..validateStatus = (int? status) {
  //       return status! > 0;
  //     }
  //     ..headers = {
  //       HttpHeaders.userAgentHeader: 'dio',
  //       HttpHeaders.authorizationHeader: 'Bearer $token'
  //     };

  //   _isLoadingMember = true;
  //   notifyListeners();

  //   print(data);

  //   try {
  //     var responseData = await dio.post(
  //       Constant.addMemberByEmail,
  //       data: data,
  //       options: Options(
  //         contentType: Headers.formUrlEncodedContentType,
  //       ),
  //     );

  //     print("RESPONSE ADD MEMBER BY EMAIL: $responseData");

  //     _responseData = responseData.data;

  //     if (responseData.data['message'] == 'true') {
  //       //
  //       print("Response success add member by email ${responseData.data}");
  //     } else {
  //       //
  //       print("Response error add member by email ${responseData.data}");
  //     }
  //   } catch (e) {
  //     print("catch $e");
  //   }

  //   _isLoadingMember = false;
  //   notifyListeners();

  //   return _responseData;
  // }

  // void clearProducts() {
  //   _productList.clear();
  //   notifyListeners();
  // }

  void clearAllCategory() {
    _categories.clear();
    notifyListeners();
  }
}
