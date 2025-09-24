import 'package:flutter/material.dart';
import 'screens/counter_home.dart';

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advanced Counter App',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const CounterHomePage(), // Panggil halaman utama
    );
  }
}
