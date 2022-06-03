import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getCity() async {
  final SharedPreferences preference = await SharedPreferences.getInstance();
  if (preference.getString('_city') != null) {
    return preference.getString('_city');
  } else {
    return "";
  }
}

Future setCity(String value) async {
  final SharedPreferences preference = await SharedPreferences.getInstance();
  preference.setString('_city', value);
}
