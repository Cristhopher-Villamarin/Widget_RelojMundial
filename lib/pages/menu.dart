import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_jm/pages/inicio1.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/tierra.jpeg'), // Reemplaza con tu ruta de imagen
            fit: BoxFit.cover, // Ajusta la imagen para que cubra toda la pantalla
          ),
        ),
        child: Center(
          child: Container(
            width: 300,
            height: 500,
            decoration: BoxDecoration(
              color: Color.fromARGB(41, 43, 1, 1), // Fondo semi-transparente para dar contraste
              border: Border.all(color: Colors.white, width: 5), // Borde amarillo
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Centrado verticalmente
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: 200,
                  child: Text(
                    'Reloj Mundial',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40, // Tamaño de fuente más grande
                      fontWeight: FontWeight.bold, // Estilo de texto en negrita
                      color: const Color.fromARGB(255, 255, 255, 255), // Color del texto
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 200,
                  child: Text(
                    'Grupo Nº2',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      color: const Color.fromARGB(255, 255, 255, 255), // Color del texto
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                // Centro del IconButton
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
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
