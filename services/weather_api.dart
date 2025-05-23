import 'dart:convert';
import 'package:http/http.dart' as http;

const String weatherApiKey = 'c4acb9b14827de37ff4dc75f8a07bd4c';
const String currentWeatherEndpoint = 'https://api.openweathermap.org/data/2.5/weather';

Future<dynamic> getWeatherForCity({required String city}) async {
  final url = Uri.parse('$currentWeatherEndpoint?units=metric&q=$city&appid=$weatherApiKey');
  //print('[DEBUG ] URL= $url');