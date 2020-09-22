import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prototype/models/admin_model.dart';
import 'package:prototype/models/student_model.dart';

class AdminController {
  AdminModel _adminModel = AdminModel();
  StudentModel _studentModel = StudentModel();
  FirebaseFirestore _database;
  String _resultInsertion;
  String _idRemotion;
  int _resultRemotion;
  int _validateAddUser;
  QuerySnapshot _snapshot;

  Future<int> verifyIfAdminExists(String username) async {
    _database = _adminModel.getConnection();
    _adminModel.setUsername(username);
    _snapshot = await _database
        .collection("admins")
        .where("username", isEqualTo: _adminModel.getUsername())
        .get();
    return _snapshot.size;
  }

  Future<String> addNewAdmin(
      String username, String password, String name) async {
    _database = _adminModel.getConnection();
    _adminModel.setUsername(username);
    _adminModel.setPassword(password);
    _adminModel.setName(name);
    _adminModel.setDate();
    _validateAddUser = await verifyIfAdminExists(username);

    if (_validateAddUser > 0) {
      _resultInsertion = "";
      return _resultInsertion;
    } else {
      DocumentReference result = await _database.collection("admins").add({
        "username": _adminModel.getUsername(),
        "password": _adminModel.getPassword(),
        "name": _adminModel.getName(),
        "dateInsertion": _adminModel.getDate()
      });
      _resultInsertion = result.id;
      return _resultInsertion;
    }
  }

  Future<int> verifyStudentExists(String username) async {
    _database = _studentModel.getConnection();
    _adminModel.setUsername(username);
    _snapshot = await _database
        .collection("students")
        .where("username", isEqualTo: _adminModel.getUsername())
        .get();
    return _snapshot.size;
  }

  Future<String> addNewStudent(String username, String password, String name,
      int age, double height, double weight) async {
    _database = _studentModel.getConnection();
    _studentModel.setUsername(username);
    _studentModel.setPassword(password);
    _studentModel.setName(name);
    _studentModel.setAge(age);
    _studentModel.setHeight(height);
    _studentModel.setWeight(weight);
    _studentModel.setDate();
    _validateAddUser = await verifyIfAdminExists(username);

    if (_validateAddUser > 0) {
      _resultInsertion = "";
      return _resultInsertion;
    } else {
      DocumentReference result = await _database.collection("students").add({
        "username": _studentModel.getUsername(),
        "password": _studentModel.getPassword(),
        "name": _studentModel.getName(),
        "age": _studentModel.getAge(),
        "height": _studentModel.getHeight(),
        "weight": _studentModel.getWeight(),
        "dateInsertion": _studentModel.getDate()
      });
      _resultInsertion = result.id;
      return _resultInsertion;
    }
  }

  Stream<QuerySnapshot> listAllStudents() {
    _database = _studentModel.getConnection();
    return _database
        .collection("students")
        .orderBy("name", descending: false)
        .snapshots();
  }

  Stream<QuerySnapshot> listAllAdmins() {
    _database = _studentModel.getConnection();
    return _database
        .collection("admins")
        .orderBy("name", descending: false)
        .snapshots();
  }

  Future<int> removeStudent(String username, bool remove) async {
    if (remove == true) {
      _database = _studentModel.getConnection();
      _snapshot = await _database
          .collection("students")
          .where("username", isEqualTo: username)
          .get();
      _snapshot.docs.forEach((item) {
        _idRemotion = item.id;
      });
      await _database.collection("students").doc(_idRemotion).delete();
      _snapshot = await _database
          .collection("students")
          .where("username", isEqualTo: username)
          .get();
      return _snapshot.size;
    } else {
      return 1;
    }
  }

  Future<int> removeAdmin(String username, bool remove) async {
    if (remove == true) {
      _database = _adminModel.getConnection();
      _snapshot = await _database
          .collection("admins")
          .where("username", isEqualTo: username)
          .get();
      _snapshot.docs.forEach((item) {
        _idRemotion = item.id;
      });
      await _database.collection("admins").doc(_idRemotion).delete();
      _snapshot = await _database
          .collection("admins")
          .where("username", isEqualTo: username)
          .get();
      return _snapshot.size;
    } else {
      return 1;
    }
  }
}
