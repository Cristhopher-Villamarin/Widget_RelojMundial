import 'package:flutter/material.dart';

class Hora extends StatelessWidget {
  final String date;
  final String time;
  final String location;

  Hora({required this.date, required this.time, required this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromARGB(98, 100, 93, 93),
        border: Border.all(color: Colors.yellow, width: 2), // Borde amarillo
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: 200,
            height: 100,
            child: Text(
              time,
              style: TextStyle(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontSize: 40,
                  decoration: TextDecoration.none),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            child: Text(
              date,
              style: TextStyle(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20,
                  decoration: TextDecoration.none),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Text(
              location,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  decoration: TextDecoration.none),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
