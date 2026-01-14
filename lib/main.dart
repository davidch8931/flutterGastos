import 'package:flutter/material.dart';

import 'screens/configuraciones/configuraciones_form_screen.dart';
import 'screens/configuraciones/configuraciones_screen.dart';
import 'screens/home_screen.dart';
import 'screens/transacciones/transaccion_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/transacciones/lista': (context) => ListaTransaccion(),

        '/configuracion': (context) => ConfiguracionScreen(),
        '/configuracion/form': (context) => ConfiguracionFormScreen(),

      }
      );
  }
}
