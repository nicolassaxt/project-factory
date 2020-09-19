import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prototype/controllers/login_controller.dart';
import 'package:prototype/routes/routes_controller.dart';
import 'package:provider/provider.dart';

import 'home_admin.dart';
import 'home_student.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LoginController _loginController = LoginController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  List<String> _options = ["Administrador", "Aluno"];
  String _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerScaffold(),
      body: bodyScaffold(),
    );
  }

  Widget headerScaffold() {
    return AppBar(
      title: Text("Sheet - Meu Treino"),
      centerTitle: true,
      backgroundColor: Colors.green,
    );
  }

  Widget bodyScaffold() {
    return Form(
      onWillPop: confirmExitApp,
      key: _globalKey,
      child: bodyForm(),
    );
  }

  Widget bodyForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            usernameField(),
            passwordField(),
            selectButton(),
            submitButton()
          ],
        ),
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
            icon: FaIcon(FontAwesomeIcons.userAlt, color: Colors.black)),
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

  Widget selectButton() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
            hintText: "Tipo de Login",
            icon: FaIcon(FontAwesomeIcons.gripVertical, color: Colors.black)),
        items: _options.map((String item) {
          return DropdownMenuItem(value: item, child: Text(item));
        }).toList(),
        onChanged: (String item) {
          setState(() {
            _selectedOption = item;
          });
        },
        value: _selectedOption,
        validator: (value) {
          if (value == null) {
            return "Selecione o tipo de usuário (a)";
          }
        },
      ),
    );
  }

  Widget submitButton() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: SizedBox(
        height: 35,
        width: 200,
        child: RaisedButton(
          child: Text("Confirmar", style: TextStyle(color: Colors.white)),
          color: Colors.green,
          onPressed: () async {
            if (_globalKey.currentState.validate()) {
              int result = await _loginController.verifyTypeOfLogin(
                  _selectedOption,
                  _usernameController.text,
                  _passwordController.text);

              resultLogin(result);
            }
          },
        ),
      ),
    );
  }

  resultLogin(int result) {
    if (result > 0) {
      LoginController _controller =
          Provider.of<LoginController>(context, listen: false);
      _controller.setCurrentUserOnline(_usernameController.text);
      RouteController().redirectCorrectHome(_loginController.getTypeOfUser());
    } else {
      errorLogin();
    }
  }

  Future<bool> errorLogin() {
    return showDialog(
        context: context,
        child: AlertDialog(
          title: Text("Erro no Login"),
          content: Text("Usuário (a) ou senha incorreto (a)",
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

  Future<bool> confirmExitApp() async {
    return showDialog(
        context: context,
        child: AlertDialog(
          title: Text("Sair do Aplicativo"),
          content: Text("Deseja mesmo sair?"),
          actions: [
            FlatButton(
              child: Text("Confirmar", style: TextStyle(color: Colors.blue)),
              onPressed: () {
                RouteController().returnOneRoute(true);
              },
            ),
            FlatButton(
              child: Text("Cancelar", style: TextStyle(color: Colors.red)),
              onPressed: () {
                RouteController().returnOneRoute(false);
              },
            )
          ],
        ));
  }
}
