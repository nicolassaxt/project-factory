import 'package:flutter/material.dart';
import 'package:prototype/controllers/login_controller.dart';
import 'package:provider/provider.dart';

class HomeStudent extends StatefulWidget {
  @override
  _HomeStudentState createState() => _HomeStudentState();
}

class _HomeStudentState extends State<HomeStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<LoginController>(
          builder: (context, loginController, widget) {
            return Text(
                "Seja Bem-Vindo " + loginController.getCurrentUserOnline());
          },
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
    );
  }
}
