import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AdminModel extends ChangeNotifier {
  String _username;
  String _password;
  String _name;
  DateTime _date;

  void setUsername(String username) {
    _username = username;
  }

  String getUsername() {
    return _username;
  }

  void setPassword(String password) {
    _password = password;
  }

  String getPassword() {
    return _password;
  }

  void setName(String name) {
    _name = name;
  }

  String getName() {
    return _name;
  }

  void setDate() {
    _date = DateTime.now();
  }

  DateTime getDate() {
    return _date;
  }

  FirebaseFirestore getConnection() {
    return FirebaseFirestore.instance;
  }
}
