import 'package:quizzie_thunder/utils/constant.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';

import '../model/product.dart';
// import '../models/content.dart';
import './user_services.dart';

mixin ComplainQuestionService on Model, UserService {
  bool _isLoadingComplainQuestion = false;
  bool get isLoadingComplainQuestion => _isLoadingComplainQuestion;

  Future<dynamic> complainQuestion(dynamic data) async {
    var _responseData;
    var dio = Dio();
    //
    dio.options
      ..baseUrl = Constant.baseUrl
      // ..connectTimeout = 10000 //5s
      // ..receiveTimeout = 10000
      ..validateStatus = (int? status) {
        return status! > 0;
      }
      ..headers = {
        HttpHeaders.userAgentHeader: 'dio',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

    _isLoadingComplainQuestion = true;
    notifyListeners();

    print(data);

    try {
      var responseData = await dio.post(
        Constant.complain_question,
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      print("RESPONSE COMPLAIN QUESTION: $responseData");

      _responseData = responseData.data;
      notifyListeners();

      if (responseData.data['data'] != null) {
        //
        print("Response complain question ${responseData.data}");
      } else {
        //
        print("Response error complain question ${responseData.data}");
      }
    } catch (e) {
      print("catch $e");
    }

    _isLoadingComplainQuestion = false;
    notifyListeners();

    return _responseData;
  }
}
