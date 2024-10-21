import 'package:shared_preferences/shared_preferences.dart';

setbul(String key, bool value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setBool(key, value);
}

getbul(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getBool(key);
}

setstring(String key, String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setString(key, value);
}

Future getstring(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString(key);
}

setstringlist(String key, List<String> value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setStringList(key, value);
}

removepref(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.remove(key);
}

Future getstringlist(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getStringList(key);
}
