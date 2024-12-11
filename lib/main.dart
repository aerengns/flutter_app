import 'package:drive_or_drunk_app/auth_wrapper.dart';
import 'package:drive_or_drunk_app/homepage.dart';
import 'package:drive_or_drunk_app/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthWrapper(),
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => const HomePage()
      },
    );
  }
}
