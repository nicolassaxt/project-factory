import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prototype/controllers/admin_controller.dart';
import 'package:prototype/models/admin_model.dart';
import 'package:prototype/routes/routes_controller.dart';
import 'package:provider/provider.dart';

class DetailsAdmin extends StatefulWidget {
  @override
  _DetailsAdminState createState() => _DetailsAdminState();
}

class _DetailsAdminState extends State<DetailsAdmin> {
  AdminController _adminController = AdminController();
  String _usernameAdmin;
  int _resultRemotion;
  bool _remove;

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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [buttonRemoveAdmin()],
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
          _usernameAdmin = adminModel.getUsername();
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

  Widget buttonRemoveAdmin() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: SizedBox(
        width: 200,
        height: 35,
        child: RaisedButton(
          child: Text("Remover", style: TextStyle(color: Colors.white)),
          color: Colors.red,
          onPressed: () async {
            await confirmRemotion();
            _resultRemotion =
                await _adminController.removeAdmin(_usernameAdmin, _remove);
            resultRemotion(_resultRemotion);
          },
        ),
      ),
    );
  }

  void resultRemotion(int result) {
    if (result > 0) {
      unespectedError();
    } else {
      successRemotion();
    }
  }

  Future<bool> successRemotion() async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        child: AlertDialog(
          title: Text("Remoção Concluída"),
          content: Text("Administrador (a) Removido (a) Com Sucesso",
              style: TextStyle(color: Colors.green)),
          actions: [
            FlatButton(
              child: Text("Confirmar", style: TextStyle(color: Colors.blue)),
              onPressed: () {
                RouteController().returnSuccessRemotionAdmin();
              },
            )
          ],
        ));
  }

  Future<bool> unespectedError() async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        child: AlertDialog(
          title: Text("Erro na Remoção"),
          content: Text("Desculpe, Algo Deu Errado, Tente Novamente",
              style: TextStyle(color: Colors.red)),
          actions: [
            FlatButton(
              child: Text("Confirmar", style: TextStyle(color: Colors.blue)),
              onPressed: () {
                RouteController().returnOneRoute(true);
              },
            ),
          ],
        ));
  }

  Future<bool> confirmRemotion() async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        child: AlertDialog(
          title: Text("Remover Administrador (a)"),
          content: Text("Deseja Mesmo Remover o Administrador (a)?"),
          actions: [
            FlatButton(
              child: Text("Confirmar", style: TextStyle(color: Colors.blue)),
              onPressed: () {
                _remove = true;
                RouteController().returnOneRoute(true);
              },
            ),
            FlatButton(
              child: Text("Cancelar", style: TextStyle(color: Colors.red)),
              onPressed: () {
                _remove = false;
                RouteController().returnOneRoute(true);
              },
            )
          ],
        ));
  }
}
