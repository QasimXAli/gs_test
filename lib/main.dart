import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gs_test/firebase_options.dart';
import 'package:gs_test/services/auth_service.dart';
import 'package:gs_test/utils/theme_manager.dart';
import 'package:gs_test/views/forgot_password/provider/forgot_password_provider.dart';
import 'package:gs_test/views/home/home_screen.dart';
import 'package:gs_test/views/home/provider/home_provider.dart';
import 'package:gs_test/views/login_screen/login_screen.dart';
import 'package:gs_test/views/login_screen/provider/login_provider.dart';
import 'package:gs_test/views/register/provider/register_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        ChangeNotifierProxyProvider<AuthService, LoginProvider>(
          create: (context) => LoginProvider(context.read<AuthService>()),
          update: (context, auth, previous) => LoginProvider(auth),
        ),
        ChangeNotifierProxyProvider<AuthService, RegisterProvider>(
          create: (context) => RegisterProvider(context.read<AuthService>()),
          update: (context, auth, previous) => RegisterProvider(auth),
        ),
        ChangeNotifierProvider<HomeProvider>(
          create: (_) => HomeProvider(),
        ),
        ChangeNotifierProxyProvider<AuthService, ForgotPasswordProvider>(
          create: (context) =>
              ForgotPasswordProvider(context.read<AuthService>()),
          update: (context, auth, previous) => ForgotPasswordProvider(auth),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeManager.themeData,
      home: AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomeScreen();
        }
        return const LoginScreen();
      },
    );
  }
}
