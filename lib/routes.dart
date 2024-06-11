import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:red_social/ui/screens/Login_Screen.dart';
import 'package:red_social/ui/screens/register_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Social Red',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegisterScreen(),  // Establece la pantalla inicial si es necesario
      getPages: [
        GetPage(name: '/', page: () => RegisterScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/register', page: () => RegisterScreen()),
      ],
    );
  }
}
