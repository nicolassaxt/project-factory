import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prototype/controllers/admin_controller.dart';
import 'package:prototype/models/student_model.dart';
import 'package:prototype/routes/routes_controller.dart';
import 'package:provider/provider.dart';

class DetailsStudent extends StatefulWidget {
  @override
  _DetailsStudentState createState() => _DetailsStudentState();
}

class _DetailsStudentState extends State<DetailsStudent> {
  AdminController _adminController = AdminController();
  String _usernameStudent;
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
      title: Text("Detalhes do Aluno (a)"),
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
            children: [usernameField()],
          ),
          Row(
            children: [nameField()],
          ),
          Row(
            children: [ageField()],
          ),
          Row(children: [heightField()]),
          Row(children: [weightField()]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [buttonRemoveStudent()],
          )
        ],
      ),
    );
  }

  Widget headerOfColumn() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: FaIcon(FontAwesomeIcons.userAlt, size: 80, color: Colors.black),
    );
  }

  Widget usernameField() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Consumer<StudentModel>(
        builder: (context, studentModel, widget) {
          _usernameStudent = studentModel.getUsername();
          return Text(
              "Usuário (a) do Aluno (a): " +
                  studentModel.getUsername().toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold));
        },
      ),
    );
  }

  Widget nameField() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Consumer<StudentModel>(
        builder: (context, studentModel, widget) {
          return Text(
              "Nome do Aluno (a): " + studentModel.getName().toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold));
        },
      ),
    );
  }

  Widget ageField() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Consumer<StudentModel>(
        builder: (context, studentModel, widget) {
          return Text(
              "Idade do Aluno (a): " +
                  studentModel.getAge().toString().toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold));
        },
      ),
    );
  }

  Widget heightField() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Consumer<StudentModel>(
        builder: (context, studentModel, widget) {
          return Text(
              "Altura do Aluno (a): " +
                  studentModel.getHeight().toString().toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold));
        },
      ),
    );
  }

  Widget weightField() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Consumer<StudentModel>(
        builder: (context, studentModel, widget) {
          return Text(
            "Peso do Aluno (a): " +
                studentModel.getWeight().toString().toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.bold),
          );
        },
      ),
    );
  }

  Widget buttonRemoveStudent() {
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
              _resultRemotion = await _adminController.removeStudent(
                  _usernameStudent, _remove);
              resultRemotion(_resultRemotion);
            },
          ),
        ));
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
          content: Text("Aluno (a) Removido (a) com Sucesso",
              style: TextStyle(color: Colors.green)),
          actions: [
            FlatButton(
                child: Text("Confirmar", style: TextStyle(color: Colors.blue)),
                onPressed: () {
                  RouteController().returnSuccessRemotionStudent();
                }),
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
            )
          ],
        ));
  }

  Future<bool> confirmRemotion() async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        child: AlertDialog(
          title: Text("Remover Aluno (a)"),
          content: Text("Deseja Mesmo Remover o Aluno (a)?"),
          actions: [
            FlatButton(
              child: Text("Confirmar", style: TextStyle(color: Colors.blue)),
              onPressed: () async {
                _remove = true;
                RouteController().returnOneRoute(true);
              },
            ),
            FlatButton(
              child: Text("Cancerlar", style: TextStyle(color: Colors.red)),
              onPressed: () {
                _remove = false;
                RouteController().returnOneRoute(true);
              },
            )
          ],
        ));
  }
}
