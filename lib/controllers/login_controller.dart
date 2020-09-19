import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:prototype/models/admin_model.dart';
import 'package:prototype/models/student_model.dart';
import 'package:prototype/routes/routes_controller.dart';

class LoginController extends ChangeNotifier {
  final AdminModel _adminModel = AdminModel();
  final StudentModel _studentModel = StudentModel();
  QuerySnapshot _snapshot;
  FirebaseFirestore _database;
  String _typeOfUser;
  String _currentUserOnline;

  void setTypeOfUser(String type) {
    _typeOfUser = type;
  }

  String getTypeOfUser() {
    return _typeOfUser;
  }

  void setCurrentUserOnline(String user) {
    _currentUserOnline = user;
    notifyListeners();
  }

  String getCurrentUserOnline() {
    return _currentUserOnline;
  }

  Future<int> verifyTypeOfLogin(
      String option, String username, String password) async {
    if (option == "Administrador") {
      return loginAdmin(username, password);
    } else {
      return loginStudent(username, password);
    }
  }

  Future<int> loginAdmin(String username, String password) async {
    _database = _adminModel.getConnection();
    _adminModel.setUsername(username);
    _adminModel.setPassword(password);
    _snapshot = await _database
        .collection("admins")
        .where("username", isEqualTo: _adminModel.getUsername())
        .where("password", isEqualTo: _adminModel.getPassword())
        .get();
    _typeOfUser = "admin";
    return _snapshot.size;
  }

  Future<int> loginStudent(String username, String password) async {
    _database = _studentModel.getConnection();
    _studentModel.setUsername(username);
    _studentModel.setPassword(password);
    _snapshot = await _database
        .collection("students")
        .where("username", isEqualTo: _studentModel.getUsername())
        .where("password", isEqualTo: _studentModel.getPassword())
        .get();
    _typeOfUser = "student";
    return _snapshot.size;
  }
}
