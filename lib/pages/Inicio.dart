import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:widget_jm/model/zona.dart';
import 'package:widget_jm/widget/hora.dart';
import 'package:http/http.dart' as http;

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  late Timer _timer;
  late Future<Zona> _listadoZona;
  List<String> lugares = [
    "America/Bogota",
    "America/New_York",
    "America/Boise",
    "Europe/Berlin"
  ];
  String _Lugar = "America/Bogota";
  Offset _offset = Offset(100, 100); // Posición inicial del widget

  Future<Zona> _getZona(String zona1) async {
    final response = await http.get(Uri.parse(
        "https://api.timezonedb.com/v2.1/get-time-zone?key=SXLJ759M12EG&format=json&by=zone&zone=$zona1"));

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      print(Zona.fromJson(jsonData).countryName);
      return Zona.fromJson(jsonData);
    } else {
      throw Exception("Fallo en la conexión");
    }
  }

  @override
  void initState() {
    super.initState();
    _listadoZona = _getZona(_Lugar);
    // Configura un timer que se ejecutará cada segundo
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      if (mounted) {
        setState(() {
          _listadoZona = _getZona(_Lugar);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.jfif',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              children: [
                SizedBox(height: 40),
                Container(
                  alignment: Alignment.center,
                  width: 190,
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
                        _listadoZona = _getZona(_Lugar);
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),
                FutureBuilder<Zona>(
                  future: _listadoZona,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else if (snapshot.hasData) {
                      return Draggable<Widget>(
                        feedback: Hora(
                          date: snapshot.data!.date,
                          time: snapshot.data!.time,
                          location:
                              "${snapshot.data!.countryName} ${snapshot.data!.zoneName}",
                        ),
                        childWhenDragging:
                            Container(), // El widget se oculta mientras se arrastra
                        onDraggableCanceled: (velocity, offset) {
                          setState(() {
                            _offset = offset;
                          });
                        },
                        child: Positioned(
                          left: _offset.dx,
                          top: _offset.dy,
                          child: Hora(
                            date: snapshot.data!.date,
                            time: snapshot.data!.time,
                            location:
                                "${snapshot.data!.countryName} ${snapshot.data!.zoneName}",
                          ),
                        ),
                      );
                    } else {
                      return Text("No hay datos");
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
