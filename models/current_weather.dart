class CurrentWeather {
  String _city;
  String _description;
  double _currentTemp;
  DateTime _currentTime;
  DateTime _sunrise;
  DateTime _sunset;
  // geters
  String get city => _city;
  String get description => _description;
  double get currentTemp => _currentTemp;
  DateTime get currentTime => _currentTime;
  DateTime get sunrise => _sunrise;
  DateTime get sunset => _sunset;

// setters
  set city(String value) {
    if (value.trim().isEmpty) throw Exception('City cannot be empty');
    _city = value;
  }

  set description(String value) {
    if (value.trim().isEmpty) throw Exception('Description cannot be empty');
    _description = value;
  }

  set currentTemp(double value) {
    if (value < -100 || value > 100) {
      throw Exception('Temperature must be between -100 and 100');
    }
    _currentTemp = value;
  }

  set currentTime(DateTime value) {
    if (value.isAfter(DateTime.now())) {
      throw Exception('Current time cannot be in the future');
    }
    _currentTime = value;
  }

  set sunrise(DateTime value) {
    if (!_isSameDay(value, _currentTime)) {
      throw Exception('Sunrise must be on the same day as current time');
    }
    if (value.isAfter(_sunset)) {
      throw Exception('Sunrise cannot be after sunset');
    }
    _sunrise = value;
  }

  set sunset(DateTime value) {
    if (!_isSameDay(value, _currentTime)) {
      throw Exception('Sunset must be on the same day as current time');
    }
    if (value.isBefore(_sunrise)) {
      throw Exception('Sunset cannot be before sunrise');
    }
    _sunset = value;
  }
  //constructor
  CurrentWeather({
    required String city,
    required String description,
    required double currentTemp,
    required DateTime currentTime,
    required DateTime sunrise,
    required DateTime sunset,
  })  : _city = city,
        _description = description,
        _currentTemp = currentTemp,
        _currentTime = currentTime,
        _sunrise = sunrise,
        _sunset = sunset {
    this.city = city;
    this.description = description;
    this.currentTemp = currentTemp;
    this.currentTime = currentTime;
    this.sunrise = sunrise;
    this.sunset = sunset;
  }

  factory CurrentWeather.fromOpenWeatherData(dynamic data) {
    int dt = ((data['dt'] ?? 0)).toInt();
    String city = data['name'] ?? '';
    String description = data['weather']?[0]?['description'] ?? '';
    double currentTemp = (data['main']?['temp'] ?? 0).toDouble();
    int sunrise = (data['sys']?['sunrise'] ?? 0).toInt();
    int sunset = (data['sys']?['sunset'] ?? 0).toInt();
    return CurrentWeather(
      city: city,
      description: description,
      currentTemp: currentTemp,
      currentTime:
      DateTime.fromMillisecondsSinceEpoch(dt * 1000, isUtc: true).toLocal(),
      sunrise: DateTime.fromMillisecondsSinceEpoch(sunrise * 1000, isUtc: true)
          .toLocal(),
      sunset: DateTime.fromMillisecondsSinceEpoch(sunset * 1000, isUtc: true)
          .toLocal(),
    );
  }

  @override
  String toString() {
    return 'City: $city, Description: $description, Current Temperature: $currentTemp, Current Time: $currentTime, Sunrise: $sunrise, Sunset: $sunset';
  }

  // check if 2 Dates are on the same Day
  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
