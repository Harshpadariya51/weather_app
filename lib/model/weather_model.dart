class weathermodel {
  final String locationName;
  final String region;
  final String country;
  final double temperatureCelsius;
  final double temperatureFahrenheit;
  final String conditionText;
  final String conditionIconUrl;
  final int windSpeedMph;
  final int windSpeedKph;
  final int windDegree;
  final String windDirection;
  final double pressureMb;
  final double pressureIn;
  final double precipitationMm;
  final double precipitationIn;
  final int humidity;
  final int cloud;
  final double feelsLikeCelsius;
  final double feelsLikeFahrenheit;
  final double visibilityKm;
  final double visibilityMiles;
  final int uvIndex;
  final double gustMph;
  final double gustKph;
  final String localtime;
  final String last_updated;
  final String icon;
  final String tzId;
  final String text;

  weathermodel({
    required this.locationName,
    required this.region,
    required this.country,
    required this.temperatureCelsius,
    required this.temperatureFahrenheit,
    required this.conditionText,
    required this.conditionIconUrl,
    required this.windSpeedMph,
    required this.windSpeedKph,
    required this.windDegree,
    required this.windDirection,
    required this.pressureMb,
    required this.pressureIn,
    required this.precipitationMm,
    required this.precipitationIn,
    required this.humidity,
    required this.cloud,
    required this.feelsLikeCelsius,
    required this.feelsLikeFahrenheit,
    required this.visibilityKm,
    required this.visibilityMiles,
    required this.uvIndex,
    required this.gustMph,
    required this.gustKph,
    required this.localtime,
    required this.last_updated,
    required this.icon,
    required this.tzId,
    required this.text,
  });

  factory weathermodel.fromJson(Map<String, dynamic> json) {
    return weathermodel(
        locationName: json['location']['name'],
        region: json['location']['region'],
        country: json['location']['country'],
        temperatureCelsius: json['current']['temp_c'].toDouble(),
        temperatureFahrenheit: json['current']['temp_f'].toDouble(),
        conditionText: json['current']['condition']['text'],
        conditionIconUrl: json['current']['condition']['icon'],
        windSpeedMph: json['current']['wind_mph'].toInt(),
        windSpeedKph: json['current']['wind_kph'].toInt(),
        windDegree: json['current']['wind_degree'].toInt(),
        windDirection: json['current']['wind_dir'],
        pressureMb: json['current']['pressure_mb'].toDouble(),
        pressureIn: json['current']['pressure_in'].toDouble(),
        precipitationMm: json['current']['precip_mm'].toDouble(),
        precipitationIn: json['current']['precip_in'].toDouble(),
        humidity: json['current']['humidity'].toInt(),
        cloud: json['current']['cloud'].toInt(),
        feelsLikeCelsius: json['current']['feelslike_c'].toDouble(),
        feelsLikeFahrenheit: json['current']['feelslike_f'].toDouble(),
        visibilityKm: json['current']['vis_km'].toDouble(),
        visibilityMiles: json['current']['vis_miles'].toDouble(),
        uvIndex: json['current']['uv'].toInt(),
        gustMph: json['current']['gust_mph'].toDouble(),
        gustKph: json['current']['gust_kph'].toDouble(),
        localtime: json['location']['localtime'],
        last_updated: json['current']['last_updated'],
        icon: json['current']['condition']['icon'],
        tzId: json['location']['tz_id'],
        text: json['current']['condition']['text'].toString());
  }
}
