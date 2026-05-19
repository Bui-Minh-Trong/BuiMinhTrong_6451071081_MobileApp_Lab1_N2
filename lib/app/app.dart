import 'package:flutter/material.dart';
import '../screens/check_email/check_email_screen.dart';
import '../screens/forgot_password/forgot_password_screen.dart';
import '../screens/logo/logo_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/signup/signup_screen.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/successfully/successfully_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jobspot',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LogoScreen(),       // ← Navy logo screen
        '/splash': (context) => const SplashScreen(), // ← White splash screen
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/check-email': (context) => const CheckEmailScreen(),
        '/successfully': (context) => const SuccessfullyScreen(),
      },
    );
  }
}

