import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:widget_jm/pages/Inicio.dart';
import 'package:widget_jm/pages/inicio1.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.bottomRight,
            radius: 3.5,
            colors: [
              Color.fromARGB(219, 104, 0, 173),
              Color.fromARGB(255, 37, 2, 61),
              Color.fromARGB(255, 37, 2, 61),
              Color.fromARGB(255, 37, 2, 61),
              Color.fromARGB(255, 37, 2, 61),
              Color.fromARGB(255, 37, 2, 61),
            ],
          ),
        ),
        child: Center(
            child: Container(
          width: 300,
          height: 500,
          decoration: BoxDecoration(
            color: Color.fromARGB(41, 43, 1, 1),
            border:
                Border.all(color: Color.fromARGB(255, 202, 3, 126), width: 5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                width: 200,
                child: Text(
                  'Zona Horaria',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40, // Tamaño de fuente más grande
                    fontWeight: FontWeight.bold, // Estilo de texto en negrita
                    color: const Color.fromARGB(
                        255, 255, 255, 255), // Color del texto
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 200,
                child: Text(
                  'Nombre: Morales Marley',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    color: const Color.fromARGB(
                        255, 255, 255, 255), // Color del texto
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      icon: Icon(
                        CupertinoIcons.time,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                      iconSize: 100,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Inicio()),
                        );
                      }),
                  SizedBox(width: 50), // Espacio entre los botones
                  IconButton(
                      icon: Icon(
                        CupertinoIcons.time_solid,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                      iconSize: 100,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Inicio1()),
                        );
                      }),
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
