import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prototype/controllers/login_controller.dart';
import 'package:prototype/routes/routes_controller.dart';
import 'package:provider/provider.dart';

class HomeAdmin extends StatefulWidget {
  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPop,
      child: Scaffold(
        appBar: headerOfScaffold(),
        drawer: drawerOfScaffold(),
      ),
    );
  }

  Widget headerOfScaffold() {
    return AppBar(
      title: Consumer<LoginController>(
        builder: (context, loginController, widget) {
          return Text(
              "Seja Bem-Vindo(a) " + loginController.getCurrentUserOnline());
        },
      ),
      backgroundColor: Colors.green,
      centerTitle: true,
    );
  }

  Widget drawerOfScaffold() {
    return Drawer(
      child: ListView(
        children: [
          headerOfDrawer(),
          drawerAddAdmin(),
          drawerAddStudent(),
          drawerListAdmins(),
          drawerListStudents(),
          drawerLogout()
        ],
      ),
    );
  }

  Widget headerOfDrawer() {
    return Container(
      height: 55,
      child: DrawerHeader(
        child: Text("Lista de Opções",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        decoration: BoxDecoration(color: Colors.green),
      ),
    );
  }

  Widget drawerAddAdmin() {
    return ListTile(
      title: Text("Cadastrar Administrador"),
      trailing: FaIcon(FontAwesomeIcons.userCog, color: Colors.black),
      onTap: () {
        RouteController().returnAddAdminView();
      },
    );
  }

  Widget drawerAddStudent() {
    return ListTile(
      title: Text("Cadastrar Aluno"),
      trailing: FaIcon(FontAwesomeIcons.userAlt, color: Colors.black),
      onTap: () {
        RouteController().returnAddStudentView();
      },
    );
  }

  Widget drawerListAdmins() {
    return ListTile(
      title: Text("Listar Administradores"),
      trailing: FaIcon(FontAwesomeIcons.usersCog, color: Colors.black),
      onTap: () {
        RouteController().returnListAdminsView();
      },
    );
  }

  Widget drawerListStudents() {
    return ListTile(
      title: Text("Listar Alunos"),
      trailing: FaIcon(FontAwesomeIcons.users, color: Colors.black),
      onTap: () {
        RouteController().returnListStudentsView();
      },
    );
  }

  Widget drawerLogout() {
    return ListTile(
      title: Text("Sair"),
      trailing: FaIcon(FontAwesomeIcons.signOutAlt, color: Colors.black),
      onTap: () {
        RouteController().logoutUser();
      },
    );
  }

  Future<bool> willPop() {
    return showDialog(
        context: context,
        child: AlertDialog(
          title: Text("Encerrar Sessão"),
          content: Text("Deseja mesmo sair?"),
          actions: [
            FlatButton(
              child: Text("Confirmar", style: TextStyle(color: Colors.blue)),
              onPressed: () {
                RouteController().exitHome(true);
              },
            ),
            FlatButton(
              child: Text("Cancelar", style: TextStyle(color: Colors.red)),
              onPressed: () {
                RouteController().exitHome(false);
              },
            )
          ],
        ));
  }
}
