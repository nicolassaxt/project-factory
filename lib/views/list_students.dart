import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prototype/controllers/admin_controller.dart';

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
            title: Text("Nome do Aluno: " + documents[index].get("name")),
            leading: CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.account_circle, color: Colors.white),
            ),
            subtitle: Text(
                "Idade do Aluno: " + documents[index].get("age").toString()),
            onTap: () {},
          );
        });
  }

  void setOperationList() {
    _operationList = _adminController.listAllStudents();
  }
}
