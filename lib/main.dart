import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restau/models/newrestaurant.dart';
import 'package:restau/services/auth/auth_gate.dart';
import 'package:restau/services/auth/login_or_register.dart';
import 'package:restau/firebase_options.dart';
import 'package:restau/models/restaurant.dart';
import 'package:restau/pages/login.dart';
import 'package:restau/pages/register_page.dart';
import 'package:restau/themes/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ChangeNotifierProvider(create: (context) => Restaurant()),
      ChangeNotifierProvider(create: (context) => NewMenuRestaurant()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
