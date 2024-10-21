import 'package:flutter/material.dart';
import 'package:trello/pages/login.dart';
import 'export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isLog = await getbul('log') ?? false;
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.indigo,
      primaryColorLight: Colors.cyan,
      appBarTheme: AppBarTheme(backgroundColor: Colors.indigo.shade300),
    ),
    themeMode: ThemeMode.light,
    darkTheme: ThemeData.dark(),
    debugShowCheckedModeBanner: false,
    routes: {
      "/": (context) => isLog ? const Home() : const LoginPage(),
    },
  ));
}
