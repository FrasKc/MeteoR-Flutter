import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class ActualCity {
  ActualCity(StreamingSharedPreferences preferences)
      : city = preferences.getString('city', defaultValue: "");

  final Preference<String> city;
}
