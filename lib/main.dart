import 'package:flutter/material.dart';
import 'vista/reloj_vista.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'World Clock',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const WorldClockWidget(city: 'Etc/GMT'), // Puedes cambiar a otra ciudad.
    );
  }
}
