import 'package:quizzie_thunder/model/score.dart';
import 'package:quizzie_thunder/utils/constant.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';

// import '../models/content.dart';
import './user_services.dart';

mixin ScoreService on Model, UserService {
  static List<Score> _scoreList = [];
  List<Score> get scoreList => _scoreList;

  static bool _isLoadingScore = false;
  bool get isLoadingScore => _isLoadingScore;

  Future<dynamic> fetchMyAvgScore() async {
    var _scoreData;

    _isLoadingScore = true;
    notifyListeners();

    var dio = Dio();
    dio.options
      ..baseUrl = Constant.baseUrl
      // ..connectTimeout = 10000 //5s
      // ..receiveTimeout = 10000
      ..queryParameters = {'token': token}
      ..validateStatus = (int? status) {
        return status! > 0;
      }
      ..headers = {
        HttpHeaders.userAgentHeader: 'dio',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      };

    List<Score> _fetchedScore = [];

    try {
      var responseData = await dio.get(
        "${Constant.average_score}/$uid",
        // data: _data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      print("RESPONSE GET MY AVERAGE SCORE: $responseData");

      _scoreData = responseData.data;

      if (responseData.data['data'] != null) {
        for (var score in responseData.data['data']) {
          _fetchedScore.add(Score.fromJson(score));
        }
      } else {
        print(
            "FETCH GET MY AVERAGE SCORE error: ${responseData.data['message']}");
      }
    } catch (e) {
      print(e);
    }

    _scoreList = _fetchedScore;

    _isLoadingScore = false;
    notifyListeners();

    return _scoreData;
  }

  Future<dynamic> submitScore(dynamic data) async {
    var _scoreData;

    _isLoadingScore = true;

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

    try {
      var responseData = await dio.post(
        "${Constant.score}",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      print("RESPONSE POST MY SCORE: $responseData");

      _scoreData = responseData.data;

      if (responseData.data['data'] != null) {
        //
        print("Success submit score");
      } else {
        print("POST MY SCORE error: ${responseData.data['message']}");
      }
    } catch (e) {
      print(e);
    }

    _isLoadingScore = false;
    notifyListeners();

    return _scoreData;
  }

  // Future<dynamic> hapusPustakaKata(dynamic idPuskat) async {
  //   dynamic _puscerData;

  //   var dio = Dio();
  //   dio.options
  //     ..baseUrl = Constant.baseUrl
  //     ..connectTimeout = 10000 //5s
  //     ..receiveTimeout = 10000
  //     ..validateStatus = (int status) {
  //       return status > 0;
  //     }
  //     ..headers = {
  //       HttpHeaders.userAgentHeader: 'dio',
  //       HttpHeaders.authorizationHeader:
  //           'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL2F1dGgvbG9naW4iLCJpYXQiOjE2OTA2MjcwOTYsImV4cCI6MTcyMjE2MzA5NiwibmJmIjoxNjkwNjI3MDk2LCJqdGkiOiJjV2NJTEQ4cDRIeEdFbUVqIiwic3ViIjoiNDYiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.pmq4SNGWrV06HSNqciuwRlQ0acKDMAjhqCKpzVGJDQ8',
  //     };

  //   _isLoadingPustakaKata = true;
  //   notifyListeners();

  //   print("URL: ${Constant.pustaka_kata}");

  //   try {
  //     var responseData = await dio.delete(
  //       "${Constant.pustaka_kata}/$idPuskat",
  //       options: Options(
  //         contentType: Headers.formUrlEncodedContentType,
  //       ),
  //     );
  //     _puscerData = responseData.data;

  //     print("RESPONSE HAPUS PUSTAKA KATA: $responseData");

  //     if (responseData.data != null) {
  //     } else {
  //       print("HAPUS PUSTAKA KATA error: ${responseData.data['message']}");
  //     }
  //   } catch (e) {
  //     print(e);
  //   }

  //   _isLoadingPustakaKata = false;
  //   notifyListeners();

  //   return _puscerData;
  // }

  // Future<PustakaKata> searchPustakaKata(String title) async {
  //   PustakaKata _puscerData;

  //   var dio = Dio();
  //   dio.options
  //     ..baseUrl = Constant.baseUrl
  //     ..connectTimeout = 10000 //5s
  //     ..receiveTimeout = 10000
  //     ..validateStatus = (int status) {
  //       return status > 0;
  //     }
  //     ..queryParameters = {"title": title}
  //     ..headers = {
  //       HttpHeaders.userAgentHeader: 'dio',
  //       HttpHeaders.authorizationHeader:
  //           'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL2F1dGgvbG9naW4iLCJpYXQiOjE2OTA2MjcwOTYsImV4cCI6MTcyMjE2MzA5NiwibmJmIjoxNjkwNjI3MDk2LCJqdGkiOiJjV2NJTEQ4cDRIeEdFbUVqIiwic3ViIjoiNDYiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.pmq4SNGWrV06HSNqciuwRlQ0acKDMAjhqCKpzVGJDQ8',
  //     };

  //   _isLoadingPustakaKata = true;
  //   notifyListeners();

  //   print(uid);

  //   List<PustakaKata> _fetchedPuscet = [];

  //   print("URL: ${Constant.search_pustaka_kata}");

  //   try {
  //     var responseData = await dio.get(
  //       "${Constant.search_pustaka_kata}",
  //       options: Options(
  //         contentType: Headers.formUrlEncodedContentType,
  //       ),
  //     );

  //     print("RESPONSE GET SEARCH PUSTAKA KATA: $responseData");

  //     if (responseData.data['data'] != null) {
  //       for (var puscet in responseData.data['data']) {
  //         print(puscet);
  //         _puscerData = PustakaKata.fromJson(puscet);

  //         print(_puscerData.createdAt);

  //         _fetchedPuscet.add(_puscerData);
  //       }
  //     } else {
  //       print(
  //           "FETCH GET SEARCH PUSTAKA KATA error: ${responseData.data['message']}");
  //     }
  //   } catch (e) {
  //     print(e);
  //   }

  //   _searchPusKatList = _fetchedPuscet;

  //   _isLoadingPustakaKata = false;
  //   notifyListeners();

  //   return _puscerData;
  // }

  void clearAverageScore() {
    _scoreList.clear();
    notifyListeners();
  }

  // void clearSearchPustakaKataList() {
  //   _searchPusKatList.clear();
  //   notifyListeners();
  // }
}
