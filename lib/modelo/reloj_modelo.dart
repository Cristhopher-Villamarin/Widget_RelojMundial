class WorldTime {
  final String location; // Ciudad.
  final String timezone; // Zona horaria.
  final String time; // Hora actual en formato HH:mm.
  final bool isDaytime; // Indica si es de día o noche.

  WorldTime({
    required this.location,
    required this.timezone,
    required this.time,
    required this.isDaytime,
  });
}
