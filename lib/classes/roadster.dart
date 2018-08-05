import 'package:intl/intl.dart';

class Roadster {
  final DateTime date;
  final num launchMass;
  final String orbit;
  final num apoapsis;
  final num periapsis;
  final num inclination;
  final num longitude;
  final num period;
  final num speed;
  final num earthDistance;
  final num marsDistance;
  final String details;

  Roadster({
    this.date,
    this.launchMass,
    this.orbit,
    this.apoapsis,
    this.periapsis,
    this.inclination,
    this.longitude,
    this.period,
    this.speed,
    this.earthDistance,
    this.marsDistance,
    this.details,
  });

  factory Roadster.fromJson(Map<String, dynamic> json) {
    return Roadster(
      date: DateTime.fromMillisecondsSinceEpoch(
        json['launch_date_unix'] * 1000,
      ),
      launchMass: json['launch_mass_kg'],
      orbit: json['orbit_type'],
      apoapsis: json['apoapsis_au'],
      periapsis: json['periapsis_au'],
      inclination: json['inclination'],
      longitude: json['longitude'],
      period: json['period_days'],
      speed: json['speed_kph'],
      earthDistance: json['earth_distance_km'],
      marsDistance: json['mars_distance_km'],
      details: json['details'],
    );
  }

  String get getDate =>
      '${DateFormat('d MMMM yyyy · HH:mm').format(date)} ${date.timeZoneName}';

  String get getLaunchMass =>
      '${NumberFormat.decimalPattern().format(launchMass)} kg';

  String get getOrbit => '${orbit[0].toUpperCase()}${orbit.substring(1)}';

  String get getApoapsis =>
      '${NumberFormat.decimalPattern().format(apoapsis)} AU';

  String get getPeriapsis =>
      '${NumberFormat.decimalPattern().format(periapsis)} AU';

  String get getInclination =>
      NumberFormat.decimalPattern().format(inclination).toString();

  String get getLongitude =>
      NumberFormat.decimalPattern().format(longitude).toString();

  String get getPeriod =>
      '${NumberFormat.decimalPattern().format(period)} days';

  String get getSpeed => '${NumberFormat.decimalPattern().format(speed)} Km/h';

  String get getEarthDistance =>
      '${NumberFormat.decimalPattern().format(earthDistance)} km';

  String get getMarsDistance =>
      '${NumberFormat.decimalPattern().format(marsDistance)} km';
}
