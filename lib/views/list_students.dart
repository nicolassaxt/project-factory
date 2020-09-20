import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prototype/controllers/admin_controller.dart';
import 'package:prototype/models/student_model.dart';
import 'package:prototype/routes/routes_controller.dart';
import 'package:provider/provider.dart';

class ListStudents extends StatefulWidget {
  @override
  _ListStudentsState createState() => _ListStudentsState();
}

class _ListStudentsState extends State<ListStudents> {
  AdminController _adminController = AdminController();
  Stream<QuerySnapshot> _operationList;
  List<DocumentSnapshot> _studentsDatabase;

  @override
  void initState() {
    super.initState();
    setOperationList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerOfScaffold(),
      body: bodyOfScaffold(),
    );
  }

  Widget headerOfScaffold() {
    return AppBar(
      title: Text("Lista de Alunos (a)"),
      centerTitle: true,
      backgroundColor: Colors.green,
    );
  }

  Widget bodyOfScaffold() {
    return controlList();
  }

  Widget controlList() {
    return StreamBuilder(
      stream: _operationList,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.none:
            return Center(child: CircularProgressIndicator());
          default:
            _studentsDatabase = snapshot.data.documents;
            return listViewStudents(_studentsDatabase);
        }
      },
    );
  }

  Widget listViewStudents(List<DocumentSnapshot> documents) {
    return ListView.builder(
        itemCount: documents.length,
        itemBuilder: (context, index) {
          return ListTile(
            trailing: FaIcon(FontAwesomeIcons.infoCircle, color: Colors.black),
            title: Text("Nome do Aluno: " + documents[index].get("name")),
            leading: CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.account_circle, color: Colors.white),
            ),
            subtitle: Text(
                "Idade do Aluno: " + documents[index].get("age").toString()),
            onTap: () {
              StudentModel _studentModel =
                  Provider.of<StudentModel>(context, listen: false);
              _studentModel.setUsername(documents[index].get("username"));
              _studentModel.setName(documents[index].get("name"));
              _studentModel.setAge(documents[index].get("age"));
              _studentModel.setHeight(documents[index].get("height"));
              _studentModel.setWeight(documents[index].get("weight"));
              RouteController().returnDetailsStudentView();
            },
          );
        });
  }

  void setOperationList() {
    _operationList = _adminController.listAllStudents();
  }
}
