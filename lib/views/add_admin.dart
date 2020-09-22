import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prototype/controllers/admin_controller.dart';
import 'package:prototype/routes/routes_controller.dart';

class AddAdmin extends StatefulWidget {
  @override
  _AddAdminState createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {
  AdminController _adminController = AdminController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String _showResultIntegrity;
  int _resultIfUserExists;

  void _resetFields(){
    _usernameController.text = "";
    _passwordController.text = "";
    _nameController.text = "";
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
      title: Text("Cadastrar Administrador"),
      centerTitle: true,
      backgroundColor: Colors.green,
    );
  }

  Widget bodyOfScaffold() {
    return Form(
      key: _globalKey,
      child: bodyOfForm(),
    );
  }

  Widget bodyOfForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconHeaderForm(),
            usernameField(),
            passwordField(),
            nameField(),
            submitForm()
          ],
        ),
      ),
    );
  }

  Widget iconHeaderForm() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: FaIcon(
        FontAwesomeIcons.userCog,
        color: Colors.black,
        size: 80,
      ),
    );
  }

  Widget usernameField() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        controller: _usernameController,
        decoration: InputDecoration(
            hintText: "Usuário (a)",
            icon: FaIcon(FontAwesomeIcons.userCog, color: Colors.black)),
        validator: (value) {
          if (value.isEmpty) {
            return "Preencha o campo do usuário (a)";
          }
        },
      ),
    );
  }

  Widget passwordField() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        obscureText: true,
        controller: _passwordController,
        decoration: InputDecoration(
            hintText: "Senha",
            icon: FaIcon(FontAwesomeIcons.key, color: Colors.black)),
        validator: (value) {
          if (value.isEmpty) {
            return "Preencha o campo da senha";
          }
        },
      ),
    );
  }

  Widget nameField() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        controller: _nameController,
        decoration: InputDecoration(
            hintText: "Nome do Administrador (a)",
            icon: FaIcon(FontAwesomeIcons.idCard, color: Colors.black)),
        validator: (value) {
          if (value.isEmpty) {
            return "Preencha o campo do nome";
          }
        },
      ),
    );
  }

  Widget submitForm() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: SizedBox(
        width: 200,
        height: 35,
        child: RaisedButton(
          child: Text("Cadastrar", style: TextStyle(color: Colors.white)),
          color: Colors.green,
          onPressed: () async {
            if (_globalKey.currentState.validate()) {
              _resultIfUserExists = await _adminController
                  .verifyIfAdminExists(_usernameController.text);
              resultOfVerification(_resultIfUserExists);
            }
          },
        ),
      ),
    );
  }

  void resultOfVerification(int result) async {
    if (result > 0) {
      errorUserExists();
    } else {
      _showResultIntegrity = await _adminController.addNewAdmin(
          _usernameController.text,
          _passwordController.text,
          _nameController.text);
      checkIntegrityAdd(_showResultIntegrity);
    }
  }

  void checkIntegrityAdd(String integrity) {
    if (integrity == "") {
      unespectedError();
    } else {
      successAddAdmin();
    }
  }

  Future<bool> successAddAdmin() async {
    return showDialog(
        context: context,
        child: AlertDialog(
          title: Text("Administrador Cadastrado (a)"),
          content: Text("Administrador (a) cadastrado (a) com sucesso",
              style: TextStyle(color: Colors.green)),
          actions: [
            FlatButton(
              child: Text("Confirmar", style: TextStyle(color: Colors.blue)),
              onPressed: () {
                RouteController().returnOneRoute(true);
                _resetFields();
              },
            )
          ],
        ));
  }

  Future<bool> errorUserExists() async {
    return showDialog(
        context: context,
        child: AlertDialog(
          title: Text("Erro no Cadastro"),
          content: Text("Usuário (a) já cadastrado",
              style: TextStyle(color: Colors.red)),
          actions: [
            FlatButton(
              child: Text("Confirmar", style: TextStyle(color: Colors.blue)),
              onPressed: () {
                RouteController().returnOneRoute(true);
              },
            )
          ],
        ));
  }

  Future<bool> unespectedError() async {
    return showDialog(
        context: context,
        child: AlertDialog(
          title: Text("Erro no Cadastro"),
          content: Text("Algo deu errado, tente novamente mais tarde!",
              style: TextStyle(color: Colors.red)),
          actions: [
            FlatButton(
              child: Text("Confirmar", style: TextStyle(color: Colors.blue)),
              onPressed: () {
                RouteController().returnOneRoute(true);
              },
            )
          ],
        ));
  }
}
