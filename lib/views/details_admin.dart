import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prototype/models/admin_model.dart';
import 'package:provider/provider.dart';

class DetailsAdmin extends StatefulWidget {
  @override
  _DetailsAdminState createState() => _DetailsAdminState();
}

class _DetailsAdminState extends State<DetailsAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerOfScaffold(),
      body: bodyOfScaffold(),
    );
  }

  Widget headerOfScaffold() {
    return AppBar(
      title: Text("Detalhes do Administrador"),
      centerTitle: true,
      backgroundColor: Colors.green,
    );
  }

  Widget bodyOfScaffold() {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [headerOfColumn()],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [usernameField()],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [nameField()],
            )
          ],
        ));
  }

  Widget headerOfColumn() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: FaIcon(FontAwesomeIcons.userCog, size: 80, color: Colors.black),
    );
  }

  Widget usernameField() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Consumer<AdminModel>(
        builder: (context, adminModel, widget) {
          return Text(
              "Usuário (a) do Aluno (a): " +
                  adminModel.getUsername().toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold));
        },
      ),
    );
  }

  Widget nameField() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Consumer<AdminModel>(
        builder: (context, adminModel, widget) {
          return Text(
              "Nome do Administrador (a): " +
                  adminModel.getName().toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold));
        },
      ),
    );
  }
}
