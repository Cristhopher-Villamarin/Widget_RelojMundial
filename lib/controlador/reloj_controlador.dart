import 'dart:convert';
import 'package:http/http.dart' as http;
import '../modelo/reloj_modelo.dart';

class WorldTimeController {
  // Método para obtener la hora según la ciudad.
  Future<WorldTime> fetchTime(String city) async {
    try {
      final url = Uri.parse('http://worldtimeapi.org/api/timezone/$city');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final datetime = data['datetime'];
        final hour = DateTime.parse(datetime).hour;

        return WorldTime(
          location: city,
          timezone: data['timezone'] ?? 'Unknown',
          time: datetime.substring(11, 16), // Formato HH:mm.
          isDaytime: hour >= 6 && hour < 18, // Verifica si es de día.
        );
      } else {
        throw Exception('Failed to load time: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching time: $e');
    }
  }
}
