class Weather{

  String _city;
  String _img;
  var _temp;
  var _temMax;
  var _tempMin;
  String _description;
  int _humidity;
  int _sunrise;
  int _sunset;

  String get city => _city;

  set city(String value) {
    _city = value;
  }

  String get img => _img;

  int get sunset => _sunset;

  set sunset(int value) {
    _sunset = value;
  }

  int get sunrise => _sunrise;

  set sunrise(int value) {
    _sunrise = value;
  }

  int get humidity => _humidity;

  set humidity(int value) {
    _humidity = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  get tempMin => _tempMin;

  set tempMin(value) {
    _tempMin = value;
  }

  get temMax => _temMax;

  set temMax(value) {
    _temMax = value;
  }

  get temp => _temp;

  set temp(value) {
    _temp = value;
  }

  set img(String value) {
    _img = value;
  }


}