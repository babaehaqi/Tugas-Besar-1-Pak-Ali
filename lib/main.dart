import 'package:flutter/material.dart';
import 'package:tugas_1_copy/screens/splash_screen.dart';
import 'package:tugas_1_copy/screens/signin_screen.dart';
import 'package:tugas_1_copy/screens/signup_screen.dart';
import 'package:tugas_1_copy/screens/otp_phone_screen.dart';
import 'package:tugas_1_copy/screens/otp_email_screen.dart';
import 'package:tugas_1_copy/screens/recovery_phone_screen.dart';
import 'package:tugas_1_copy/screens/recovery_email_screen.dart';
import 'package:tugas_1_copy/screens/reset_password_screen.dart';
import 'package:tugas_1_copy/screens/user_profile_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const EcowalkApp());
}

class EcowalkApp extends StatelessWidget {
  const EcowalkApp({super.key});

  static const Color brandPrimaryColor = Color(0xFF1A6556);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecowalk',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: brandPrimaryColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: brandPrimaryColor,
          primary: brandPrimaryColor,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/verificationWithNoHP': (context) => const PhoneOtpScreen(),
        '/verificationWithEmail': (context) => const EmailOtpScreen(),
        '/forpassNoHp': (context) => const ForpassPhoneScreen(),
        '/forpassEmail': (context) => const ForpassEmailScreen(),
        '/changePass': (context) => const ChangePasswordScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
