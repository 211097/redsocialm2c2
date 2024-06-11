import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:red_social/ui/screens/Login_Screen.dart';
import 'package:red_social/ui/screens/home_page.dart';
import 'package:red_social/ui/screens/register_screen.dart';  // Asegúrate de que la ruta sea correcta
import 'controllers/auth_controller.dart';  // Importa el controlador

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.appAttest,
  );

  // Inicializa el AuthController aquí con permanent: true
  Get.put(AuthController(), permanent: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'RedBase',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',  // Ruta inicial
      getPages: [
        GetPage(name: '/', page: () => RegisterScreen()),  // Define la pantalla de registro
        GetPage(name: '/login', page: () => LoginScreen()),  // Define la pantalla de inicio de sesión
        GetPage(name: '/home', page: () => HomePage()),
      ],
    );
  }
}
