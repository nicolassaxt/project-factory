import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototype/controllers/login_controller.dart';
import 'package:prototype/models/admin_model.dart';
import 'package:prototype/views/add_admin.dart';
import 'package:prototype/views/add_student.dart';
import 'package:prototype/views/home_admin.dart';
import 'package:prototype/views/home_page.dart';
import 'package:prototype/views/home_student.dart';
import 'package:prototype/views/list_admins.dart';
import 'package:prototype/views/list_students.dart';
import 'package:provider/provider.dart';
import 'package:prototype/models/admin_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginController>.value(value: LoginController()),
        ChangeNotifierProvider<AdminModel>.value(
          value: AdminModel(),
        )
      ],
      child: GetMaterialApp(
        initialRoute: "/",
        getPages: [
          GetPage(name: "/", page: () => HomePage()),
          GetPage(name: "/homeAdmin", page: () => HomeAdmin()),
          GetPage(name: "/homeStudent", page: () => HomeStudent()),
          GetPage(name: "/addAdmin", page: () => AddAdmin()),
          GetPage(name: "/addStudent", page: () => AddStudent()),
          GetPage(name: "/listStudents", page: () => ListStudents()),
          GetPage(name: "/listAdmins", page: () => ListAdmins())
        ],
      )));
}
