import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prototype/controllers/admin_controller.dart';

class ListAdmins extends StatefulWidget {
  @override
  _ListAdminsState createState() => _ListAdminsState();
}

class _ListAdminsState extends State<ListAdmins> {
  AdminController _adminController = AdminController();
  Stream<QuerySnapshot> _operationList;
  List<DocumentSnapshot> _adminsDatabase;

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
      title: Text("Lista de Administradores"),
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
            _adminsDatabase = snapshot.data.documents;
            return listViewAdmins(_adminsDatabase);
        }
      },
    );
  }

  Widget listViewAdmins(var documents) {
    return ListView.builder(
      itemCount: documents.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("Nome do Administrador: " + documents[index].get("name")),
          leading: CircleAvatar(
            backgroundColor: Colors.green,
            child: Icon(Icons.account_circle, color: Colors.white),
          ),
          subtitle: Text(
              "Usuário do Administrador: " + documents[index].get("username")),
          onTap: () {},
        );
      },
    );
  }

  void setOperationList() {
    _operationList = _adminController.listAllAdmins();
  }
}
