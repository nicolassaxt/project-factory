import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prototype/controllers/admin_controller.dart';
import 'package:prototype/routes/routes_controller.dart';

class AddStudent extends StatefulWidget {
  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  AdminController _adminController = AdminController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String _showResultOfIntegrity;
  int _resultOfExistUser;

  void _resetFields(){
    _usernameController.text = "";
    _passwordController.text = "";
    _nameController.text = "";
    _heightController.text = "";
    _weightController.text = "";
    _ageController.text = "";
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
      title: Text("Cadastrar Aluno"),
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
            headerOfColumn(),
            usernameField(),
            passwordField(),
            nameField(),
            ageField(),
            heightField(),
            weightField(),
            submitForm()
          ],
        ),
      ),
    );
  }

  Widget headerOfColumn() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: FaIcon(FontAwesomeIcons.userPlus, size: 80, color: Colors.black),
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
            return "Preencha o campo de usuário (a)";
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
            hintText: "Nome do Aluno (a)",
            icon: FaIcon(FontAwesomeIcons.idCard, color: Colors.black)),
        validator: (value) {
          if (value.isEmpty) {
            return "Preencha o campo do nome";
          }
        },
      ),
    );
  }

  Widget ageField() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: _ageController,
        decoration: InputDecoration(
            hintText: "Idade do Aluno (a)",
            icon: FaIcon(FontAwesomeIcons.birthdayCake, color: Colors.black)),
        validator: (value) {
          if (value.isEmpty) {
            return "Preencha o campo da idade";
          }
        },
      ),
    );
  }

  Widget heightField() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: _heightController,
        decoration: InputDecoration(
            hintText: "Altura do Aluno (a) em CM",
            icon: FaIcon(FontAwesomeIcons.male, color: Colors.black)),
        validator: (value) {
          if (value.isEmpty) {
            return "Preencha o campo da altura";
          }
        },
      ),
    );
  }

  Widget weightField() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: _weightController,
        decoration: InputDecoration(
            hintText: "Peso do Aluno (a)",
            icon: FaIcon(FontAwesomeIcons.weight, color: Colors.black)),
        validator: (value) {
          if (value.isEmpty) {
            return "Preencha o campo de peso";
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
              _resultOfExistUser = await _adminController
                  .verifyStudentExists(_usernameController.text);
              resultOfVerification(_resultOfExistUser);
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
      _showResultOfIntegrity = await _adminController.addNewStudent(
          _usernameController.text,
          _usernameController.text,
          _nameController.text,
          int.parse(_ageController.text),
          double.parse(_heightController.text),
          double.parse(_weightController.text));
      checkIntegrity(_showResultOfIntegrity);
    }
  }

  void checkIntegrity(String integrity) {
    if (integrity == "") {
      unespectedError();
    } else {
      successAddStudent();
    }
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

  Future<bool> successAddStudent() async {
    return showDialog(
        context: context,
        child: AlertDialog(
          title: Text("Cadastro Concluído"),
          content: Text("Usuário (a) cadastrado com sucesso",
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

  Future<bool> unespectedError() async {
    return showDialog(
        context: context,
        child: AlertDialog(
          title: Text("Erro no Cadastro"),
          content: Text("Desculpe, algo deu errado, tente novamente",
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
