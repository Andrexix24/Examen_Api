import 'package:examen_api/screens/agregar.dart';
// import 'package:examen_api/screens/editar.dart';
import 'package:examen_api/screens/listar.dart';
import 'package:examen_api/screens/menu.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':(context) => const Menu(),
        '/listar':(context) => const Listar(),
        '/agregar':(context) => const Agregar(),
        // '/editar':(context) => const Editar()
      },
    );
  }
}
