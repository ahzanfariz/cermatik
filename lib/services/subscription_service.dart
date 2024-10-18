import '../model/subscription.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';

import '../utils/constant.dart';
import './user_services.dart';

mixin SubscriptionService on Model, UserService {
  List<Subscription> _subscriptionList = [];
  List<Subscription> get subscriptionList => _subscriptionList;

  bool _isLoadingSubscription = false;
  bool get isLoadingSubscription => _isLoadingSubscription;

  Future<dynamic> fetchSubscriptions() async {
    var _subsData;

    _isLoadingSubscription = true;
    notifyListeners();

    var dio = Dio();
    dio.options
      ..baseUrl = Constant.baseUrl
      ..connectTimeout = Duration(milliseconds: 10000) //5s
      ..receiveTimeout = Duration(milliseconds: 10000)
      ..validateStatus = (int? status) {
        return status! > 0;
      }
      ..headers = {
        HttpHeaders.userAgentHeader: 'dio',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      };

    List<Subscription> _fetchedSubs = [];

    try {
      var responseData = await dio.get(
        "${Constant.subscription}/$uid",
        // data: _data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      print("${Constant.subscription}/$uid");

      print("RESPONSE GET MY SUBSCRIPTION: $responseData");

      _subsData = responseData.data;

      if (responseData.data['message'] == 'true') {
        for (var subs in responseData.data['data']) {
          print(subs);

          _fetchedSubs.add(Subscription.fromJson(subs));
        }
      } else {
        print(
            "FETCH GET MY SUBSCRIPTION error: ${responseData.data['message']}");
      }
    } catch (e) {
      print(e);
    }

    _subscriptionList = _fetchedSubs;

    _isLoadingSubscription = false;
    notifyListeners();

    return _subsData;
  }

  Future<Map> subscriptionPlan(Map data) async {
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

    _isLoadingSubscription = true;
    notifyListeners();

    print(data);

    try {
      var responseData = await dio.post(
        Constant.subscription,
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      print("RESPONSE SUBSCRIPTION PLAN: $responseData");

      _responseData = responseData.data;
      notifyListeners();

      if (responseData.data['data'] != null) {
        //
        print("Response success subs plan ${responseData.data}");
      } else {
        //
        print("Response error subs plan ${responseData.data}");
      }
    } catch (e) {
      print("catch $e");
    }

    _isLoadingSubscription = false;
    notifyListeners();

    return _responseData;
  }

  Future<Map> makePayment(dynamic data) async {
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

    _isLoadingSubscription = true;
    notifyListeners();

    print(data);

    try {
      var responseData = await dio.post(
        Constant.payment,
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      print("RESPONSE MAKE A PAYMENT: $responseData");

      _responseData = responseData.data;
      notifyListeners();

      if (responseData.data['data'] != null) {
        //
        print("Response make a payment ${responseData.data}");
      } else {
        //
        print("Response error make a payment ${responseData.data}");
      }
    } catch (e) {
      print("catch $e");
    }

    _isLoadingSubscription = false;
    notifyListeners();

    return _responseData;
  }

  void clearMySubscriptions() {
    _subscriptionList.clear();
    notifyListeners();
  }
}
