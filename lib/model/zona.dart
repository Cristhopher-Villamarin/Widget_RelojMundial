class Zona {
  final String zoneName;
  final String countryName;
  final String date;
  final String time;
  Zona(this.zoneName, this.countryName, this.date, this.time);

  factory Zona.fromJson(Map<String, dynamic> json) {
    String formatted = json['formatted'];
    List<String> splitDateTime = formatted.split(' ');

    String timePart = splitDateTime[1];
    List<String> splitTime = timePart.split(':');

    String hoursMinutes = '${splitTime[0]}:${splitTime[1]}';

    return Zona(
      json['zoneName'],
      json['countryName'],
      splitDateTime[0],
      hoursMinutes,
    );
  }
}
