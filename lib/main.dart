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
      home: const CitySelector(),
    );
  }
}

class CitySelector extends StatelessWidget {
  const CitySelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cities = [
      'Etc/GMT',
      'America/New_York',
      'Europe/London',
      'Asia/Tokyo'
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Select a City')),
      body: ListView.builder(
        itemCount: cities.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cities[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => WorldClockWidget(city: cities[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
