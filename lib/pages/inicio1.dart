import 'dart:async';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:widget_jm/widget/hora.dart';

class Inicio1 extends StatefulWidget {
  const Inicio1({super.key});

  @override
  State<Inicio1> createState() => _Inicio1State();
}

class _Inicio1State extends State<Inicio1> {
  late Timer _timer;
  List<String> lugares = [
    "America/Bogota",
    "America/New_York",
    "America/Boise",
    "Europe/Berlin",
    "America/Guayaquil",
    "Asia/Singapore",
    "America/Argentina/Buenos_Aires",
    "America/Lima",
    "Europe/London",
    "Asia/Tokyo",
    "Australia/Sydney",
    "Europe/Paris",
    "America/Los_Angeles",
    "Asia/Shanghai",
    "Asia/Dubai",
    "Africa/Johannesburg",
    "America/Mexico_City",
    "Asia/Seoul",
    "America/Sao_Paulo",
    "Asia/Kolkata",
  ];

  String _Lugar = "America/Guayaquil";
  late tz.TZDateTime _currentDateTime;

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    _updateTime();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _updateTime();
        });
      }
    });
  }

  void _updateTime() {
    final location = tz.getLocation(_Lugar);
    _currentDateTime = tz.TZDateTime.now(location);
  }

  Widget _getIconBasedOnTime() {
    int hour = int.parse(_currentDateTime.toString().split(' ')[1].split(':')[0]);
    if (hour >= 6 && hour < 18) {
      return Icon(Icons.wb_sunny, size: 50, color: Colors.yellow); // Sol
    } else {
      return Icon(Icons.nightlight_round, size: 50, color: Colors.white); // Luna
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                'assets/images/vertical.jpg',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                SizedBox(height: 50),
                Container(
                  alignment: Alignment.center,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(99, 197, 156, 156),
                  ),
                  child: DropdownButton<String>(
                    value: _Lugar,
                    underline: Container(),
                    focusColor: Colors.transparent,
                    icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                    dropdownColor: Color.fromARGB(216, 231, 231, 231),
                    items: lugares.map((String lugar) {
                      return DropdownMenuItem<String>(
                        value: lugar,
                        child: Text(lugar),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _Lugar = newValue!;
                        _updateTime();
                      });
                    },
                  ),
                ),
                SizedBox(height: 40),
                _getIconBasedOnTime(),
                Draggable(
                  feedback: Container(
                    width: 200,
                    height: 250,
                    color: Colors.transparent,
                    child: Hora(
                      date: _currentDateTime.toString().split(' ')[0],
                      time: _currentDateTime.toString().split(' ')[1].split('.')[0],
                      location: _Lugar,
                    ),
                  ),
                  childWhenDragging: Container(
                    width: 200,
                    height: 250,
                    color: Colors.transparent,
                  ),
                  child: Container(
                    width: 200,
                    height: 250,
                    child: Hora(
                      date: _currentDateTime.toString().split(' ')[0],
                      time: _currentDateTime.toString().split(' ')[1].split('.')[0],
                      location: _Lugar,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
