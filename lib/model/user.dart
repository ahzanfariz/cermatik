import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  int? id;
  String? name;
  String? email;
  var isVerified;
  String? createdAt;
  String? updatedAt;
  String? emailVerifiedAt;
  String? address;
  String? about;
  String? image;
  String? city;
  String? organization;
  String? phone;
  String? accumulatedExpired;
  int? jumlahHariExpired;

  User(
      {this.id,
      this.name,
      this.email,
      this.isVerified,
      this.createdAt,
      this.updatedAt,
      this.about,
      this.image,
      this.emailVerifiedAt,
      this.address,
      this.phone,
      this.organization,
      this.accumulatedExpired,
      this.jumlahHariExpired});

  User.fromJson(Map<String, dynamic> json, String token) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    about = json['about'];
    emailVerifiedAt = json['email_verified_at'];
    address = json['address'];
    city = json['city'];
    organization = json['organization'];
    phone = json['phone'];
    accumulatedExpired = json['accumulated_expired'];
    jumlahHariExpired = json['jumlahHariExp'];

    saveToSqlite(json, token);
  }

  void saveToSqlite(Map<String, dynamic> json, String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Future.wait([
      prefs.setInt('uid', json['id']),
      prefs.setString('token', token),
      // prefs.setString('fcmToken', json['fcm']),
      // prefs.setString('email_verified_at', json['email_verified_at'] ?? ""),
      prefs.setString('name', json['name']),
      // prefs.setString('roles', json['roles'] == null ? "USER" : json['roles']),
      prefs.setString('email', json['email']),
    ]);
  }
}
