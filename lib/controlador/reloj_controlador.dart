import 'dart:convert';
import 'package:http/http.dart' as http;
import '../modelo/reloj_modelo.dart';

class WorldTimeController {
  Future<WorldTime> fetchTime(String city) async {
    final url = Uri.parse('http://worldtimeapi.org/api/timezone/Etc/GMT');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final datetime = data['datetime'];
      final hour = DateTime.parse(datetime).hour;

      return WorldTime(
        location: city,
        timezone: data['timezone'] ?? 'Unknown',
        time: datetime.substring(11, 16), // Extrae la hora en formato HH:mm.
        isDaytime: hour >= 6 && hour < 18, // Día entre 6:00 y 18:00.
      );
    } else {
      throw Exception('Failed to load time: ${response.statusCode}');
    }
  }
}
