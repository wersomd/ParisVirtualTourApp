import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wersomd_app/views/auth/signin.dart';
import 'package:wersomd_app/views/auth/signup.dart';
import 'package:wersomd_app/views/home/profile.dart';
import 'package:wersomd_app/views/home/welcome.dart';
import 'package:wersomd_app/views/wrapper/main_wrapper.dart';
import 'package:wersomd_app/services/firebase_stream.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Тур по Парижу",
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const FirebaseStream(),
        '/home': (context) => const MainWrapper(),
        '/profile': (context) => const ProfilePage(),
        '/login': (context) => const SignInPage(),
        '/signup': (context) => const SignUpPage(),
        '/welcome': (context) => const WelcomePage(),
      },
      initialRoute: '/',
    );
  }
}
