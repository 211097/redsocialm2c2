import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:red_social/ui/screens/Login_Screen.dart';
import 'package:red_social/ui/screens/home_page.dart';
import 'ui/screens/register_screen.dart';  // Asegúrate de que la ruta sea correcta


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    // You can also use a `ReCaptchaEnterpriseProvider` provider instance as an
    // argument for `webProvider`
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Safety Net provider
    // 3. Play Integrity provider
    androidProvider: AndroidProvider.debug,
    // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
    // your preferred provider. Choose from:aaa
    // 1. Debug provider
    // 2. Device Check provider
    // 3. App Attest provider
    // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
    appleProvider: AppleProvider.appAttest,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'RedBase',
      debugShowCheckedModeBanner: false,  // Desactiva la etiqueta de debug
      initialRoute: '/',  // Ruta inicial
      getPages: [
        GetPage(name: '/', page: () => RegisterScreen()),  // Define la pantalla de registro
        GetPage(name: '/login', page: () => LoginScreen()),  // Define la pantalla de inicio de sesión
        GetPage(name: '/home', page: () => HomePage()),

        // Puedes añadir más rutas aquí si es necesario
      ],
    );
  }
}