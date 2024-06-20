import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agri_tech/models/user.dart';
import 'package:agri_tech/pages/auth/login.dart';
import 'package:agri_tech/pages/auth/register.dart';
import 'package:agri_tech/pages/main.dart';
import 'package:agri_tech/providers/auth_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool authenticated = false;
  bool hasShownIntro = false;
  bool hasLoginHistory = true;

  @override
  void initState() {
    super.initState();
    preAuth();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      builder: (context, snapshot) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        enableLog: false,
        title: "BayKart",
        theme: ThemeData(
          primarySwatch: Colors.pink,
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: Colors.pink,
          ),
        ),
        onInit: () => validateAuth(context),
        onReady: () => validateAuth(context),
        home: const SizedBox(
          width: double.infinity,
          child: RegisterPage(),
        ),
      ),
    );
  }

  preAuth() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        hasShownIntro = preferences.getBool('hasShownIntroVideo') ?? false;
        hasLoginHistory = preferences.getBool('hasLoginHistory') ?? false;
      });
    }
    if (preferences.get('user') != null) {
      setState(() {
        authenticated = true;
        hasShownIntro = preferences.getBool('hasShownIntroVideo') ?? false;
        hasLoginHistory = preferences.getBool('hasLoginHistory') ?? false;
      });
    }
  }

  validateAuth(BuildContext context) async {
    final provider = context.read<AuthProvider>();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.get('user') != null) {
      final user = User.fromJson(
        jsonDecode(preferences.get('user').toString()),
      );
      provider.setUser(user);
      setState(() {
        authenticated = true;
      });
    }
  }
}
