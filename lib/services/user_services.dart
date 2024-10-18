import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';

import '../model/user.dart';
import '../utils/constant.dart';

mixin UserService on Model {
  User users = User();
  User get user => users;

  String _message = "";
  String get message => _message;

  String? _nama = "";
  String get nama => _nama!;

  String? _email = "";
  String get email => _email!;

  String? _phone = "";
  String get phone => _phone!;

  String? _address = "";
  String get address => _address!;

  String? _about = "";
  String get about => _about!;

  String? _organization = "";
  String get organization => _organization!;

  int? _uid;
  int get uid => _uid!;

  String _token = "";
  String get token => _token;

  // String? _fcmToken = "";
  // String? get fcmToken => _fcmToken;

  bool _isLoadingUser = false;
  bool get isLoadingUser => _isLoadingUser;

  // final _firebaseMessaging = FirebaseMessaging.instance;

  Future buildDelayed() async {
    _isLoadingUser = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2), () async {
      // do something here
      _isLoadingUser = false;
      notifyListeners();
      // do stuff
    });
  }

  Future<Map> signUp(Map data) async {
    _isLoadingUser = true;
    notifyListeners();

    var dio = Dio();
    var _responseUser;

    dio.options
      ..baseUrl = Constant.baseUrl
      // ..connectTimeout = 10000 //5s
      // ..receiveTimeout = 10000
      ..validateStatus = (int? status) {
        return status! > 0;
      }
      ..headers = {
        HttpHeaders.userAgentHeader: 'dio',
        'common-header': 'xx',
      };

    print(token);

    try {
      var responseData = await dio.post(
        Constant.register,
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      print("RESPONSE SIGNUP: ${responseData.data}");

      _responseUser = responseData.data;
      //
      if (responseData.data['user'] != null) {
        _uid = responseData.data['user']['id'];
        _email = responseData.data['user']['email'];
        _nama = responseData.data['user']['name'];
        _phone = responseData.data['user']['phone'];
        _address = responseData.data['user']['address'];
        _about = responseData.data['user']['about'];
        _organization = responseData.data['user']['organization'];
        _token = responseData.data["token"];

        notifyListeners();

        //
      } else {
        print("Response signup error: ${responseData.data}");

        _message = responseData.data['email'][0];
        _phone = null;
        _email = null;
        _nama = null;
        _address = null;
        _about = null;
        _organization = null;
        _uid = null;
      }
    } catch (e) {
      print(e);
    }

    _isLoadingUser = false;
    notifyListeners();

    return _responseUser;
  }

  Future<Map> sendOTPemail(Map data) async {
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
        'common-header': 'xx',
      };

    _isLoadingUser = true;
    notifyListeners();

    print(data);

    try {
      var responseData = await dio.post(
        data['user'] == null
            ? "${Constant.otp}/${data['id']}"
            : "${Constant.otp}/${data['user']['id']}",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      print("RESPONSE OTP: $responseData");

      _responseData = responseData.data;
      notifyListeners();

      if (responseData.statusCode == 200) {
        //
        print("Response success send otp email ${responseData.data}");
      } else {
        //
        print("Response error send otp email ${responseData.data}");
      }
    } catch (e) {
      print("catch $e");
    }

    _isLoadingUser = false;
    notifyListeners();

    return _responseData;
  }

  Future<Map> sendVerifiedEmail(Map data) async {
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
        'common-header': 'xx',
      };

    _isLoadingUser = true;
    notifyListeners();

    try {
      var responseData = await dio.get(
        data['user'] == null
            ? "${Constant.verify}/${data['id']}"
            : "${Constant.verify}/${data['user']['id']}",
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      print("RESPONSE VERIFY EMAIL: $responseData");

      _responseData = responseData.data;
      notifyListeners();

      if (responseData.data['id'] != null) {
        //
        users = User.fromJson(responseData.data, _token);
        //
        _uid = responseData.data['id'];
        _email = responseData.data['email'];
        _nama = responseData.data['name'];
        _phone = responseData.data['phone'];
        _address = responseData.data['address'];
        _about = responseData.data['about'];
        _organization = responseData.data['organization'];

        notifyListeners();
        //
      } else {
        _phone = null;
        _email = null;
        _nama = null;
        _address = null;
        _about = null;
        _organization = null;
        _uid = null;
      }
    } catch (e) {
      print("catch $e");
    }

    _isLoadingUser = false;
    notifyListeners();

    return _responseData;
  }

  Future<dynamic> signIn(Map data) async {
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
        'common-header': 'xx',
      };

    _isLoadingUser = true;
    notifyListeners();

    print(data['email']);
    print(data['password']);

    try {
      var responseData = await dio.post(
        Constant.login,
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      print("RESPONSE LOGIN: ${responseData.data}");

      _responseData = responseData;

      if (responseData.statusCode == 200) {
        print("email_verified_at: ${responseData.data['email_verified_at']}");
        //
        _token = responseData.data['token'];
        _uid = responseData.data['id'];
        _nama = responseData.data['name'];
        _phone = responseData.data['phone'];
        _email = responseData.data['email'];
        _address = responseData.data['address'];
        _about = responseData.data['about'];
        _organization = responseData.data['organization'];
        // _message = responseData.data['avatar'];

        if (responseData.data['email_verified_at'] != null) {
          print("maasuk sini");
          //
          users = User.fromJson(
            responseData.data,
            responseData.data['token'],
          );
          //
          notifyListeners();
          //
        } else {
          print("need verif email");
        }

        notifyListeners();

        //
      } else {
        // users = null;
        _message = "Email or Password is Incorrect. Please try again";
        _uid = null;
        _token = "";
        _phone = null;
        _nama = null;
        _email = null;
        _address = null;
        _about = null;
        _organization = null;
        // throw Exception('failed to load data');
      }
    } catch (e) {
      print("catch $e");
    }

    _isLoadingUser = false;
    notifyListeners();

    return _responseData;
  }

  Future<dynamic> sendResetPassword(Map data) async {
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
        'common-header': 'xx',
      };

    _isLoadingUser = true;
    notifyListeners();

    print(data['email']);

    try {
      var responseData = await dio.post(
        "${Constant.resetPassword}/${data['email']}",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      print("RESPONSE RESET PASSWORD: $responseData");

      _responseData = responseData;
      notifyListeners();

      if (responseData.statusCode == 200) {
        //
        print("Response success send reset pass ${responseData.data}");
        //
      } else {
        print("Response error send reset pass ${responseData.data}");
      }
    } catch (e) {
      print("catch $e");
    }

    _isLoadingUser = false;
    notifyListeners();

    return _responseData;
  }

  Future logOut() async {
    _isLoadingUser = true;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await Future.delayed(Duration(seconds: 2), () async {
      await Future.wait([
        prefs.setInt('uid', 0),
        prefs.setString('token', ""),
        // prefs.setString('phone', ""),
        // prefs.setString('email_verified_at', json['email_verified_at'] ?? ""),
        prefs.setString('name', ""),
        // prefs.setString('roles', ""),
        prefs.setString('email', ""),
        // prefs.setString('address', ""),
        // prefs.setString('city', ""),
        // prefs.setString('zip_code', ""),
      ]);

      _isLoadingUser = false;
      notifyListeners();
    });
  }

  Future<User> fetchUser() async {
    var dio = Dio();
    dio.options
      ..baseUrl = Constant.baseUrl
      // ..connectTimeout = 10000 //5s
      // ..receiveTimeout = 10000
      ..validateStatus = (int? status) {
        return status! > 0;
      }
      ..headers = {
        HttpHeaders.userAgentHeader: 'dio',
        // HttpHeaders.authorizationHeader: 'Bearer $_token',
        HttpHeaders.authorizationHeader: 'Bearer $_token'
      };

    _isLoadingUser = true;
    notifyListeners();

    print("${Constant.baseUrl}${Constant.profile}/$_uid");
    print(_token);

    try {
      var responseData = await dio.get(
        "${Constant.profile}/$_uid",
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      print("GET PROFILE RESPONSE: $responseData");

      if (responseData.data['data'] != null) {
        users = User.fromJson(responseData.data['data'], _token);
        //
        _uid = responseData.data['data']['id'];
        // _role = responseData.data['data']['roles'];
        _email = responseData.data['data']['email'];
        _nama = responseData.data['data']['name'];
        _phone = responseData.data['data']['phone'];
        // _address = responseData.data['data']['address'];
        _organization = responseData.data['data']['organization'];
        // _zipCode = responseData.data['data']['zip_code'];
      } else {
        print("Fetch user error: ${responseData.data}");
        // users = null;
      }
    } catch (e) {
      print(e);
    }

    _isLoadingUser = false;
    notifyListeners();

    return users;
  }

  Future<Map> editProfile(dynamic data) async {
    dynamic _responseData;

    var dio = Dio();
    dio.options
      ..baseUrl = Constant.baseUrl
      // ..connectTimeout = 10000
      // ..receiveTimeout = 10000
      ..validateStatus = (int? status) {
        return status! > 0;
      }
      ..headers = {
        HttpHeaders.userAgentHeader: 'dio',
        HttpHeaders.authorizationHeader: 'Bearer $_token',
      };

    _isLoadingUser = true;
    notifyListeners();

    try {
      print("data $data");

      var responseData = await dio.post(
        "${Constant.profile}/${user.id}",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      print("${Constant.profile}/${user.id}");

      print("RESPONSE EDIT PROFILE: ${responseData.data}");

      _responseData = responseData.data;
      if (responseData.statusCode == 200) {
        //
        users = User.fromJson(responseData.data['data'], _token);
        //
        _message = "Profile updated";
        notifyListeners();
        //
      } else {
        _message = "Failed to update your profile";
        print("Response error edit profile: ${responseData.data['message']}");
      }
    } catch (e) {
      print(e);
    }

    _isLoadingUser = false;
    notifyListeners();

    return _responseData;
  }

  Future<Response<dynamic>> changePassword(dynamic data) async {
    dynamic _responseData;

    var dio = Dio();
    dio.options
      ..baseUrl = Constant.baseUrl
      // ..connectTimeout = 10000 //5s
      // ..receiveTimeout = 10000
      ..validateStatus = (int? status) {
        return status! > 0;
      }
      ..headers = {
        HttpHeaders.userAgentHeader: 'dio',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      };

    _isLoadingUser = true;
    notifyListeners();

    print(token);

    try {
      var responseData = await dio.post(
        "${Constant.profile}/$_uid",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      print("${Constant.profile}/$_uid");
      print("RESPONSE CHANGE PASSWORD: ${responseData.data}");
      //
      _responseData = responseData;

      if (responseData.data['message'] == 'true') {
        // for (var renkers in responseData.data['data']['records']) {
        print("Response success change password ${responseData.data}");
      } else {
        print(
            "Response error change password: ${responseData.data['message']}");
      }
    } catch (e) {
      print(e);
    }

    _isLoadingUser = false;
    notifyListeners();

    return _responseData;
  }

  // // Future getDIDfcmToken(BuildContext context) async {
  // //   _fcmToken = await _firebaseMessaging.getToken();
  // //   notifyListeners();
  // //   //
  // //   print("Token FCM: $_fcmToken");
  // // }

  // // Future removeFcmToken(BuildContext context) async {
  // //   await _firebaseMessaging.deleteToken();
  // //   _fcmToken = "";
  // //   notifyListeners();
  // //   //
  // //   print("Token FCM: $_fcmToken");
  // // }

  Future<Map> checkUid() async {
    var _data;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // load variable

    _uid = prefs.getInt('uid');
    _token = prefs.getString('token') ?? "";
    // _message = (prefs.getString('avatar'));
    _nama = prefs.getString('name') ?? "";
    _email = prefs.getString('email');
    // _idUser = (prefs.getInt('idUser'));

    _data = {
      'uid': _uid,
      'token': _token,
      'name': _nama,
      'email': _email,
    };

    notifyListeners();

    print(_data['uid']);
    print(_data['token']);
    print(_data['nama']);
    print(_data['email']);

    return _data;
  }

  void clearUser() {
    users = User();
    notifyListeners();
  }
}
