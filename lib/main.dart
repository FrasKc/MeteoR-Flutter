import 'package:flutter/material.dart';
import 'package:meteor/pages/home.dart';
import 'package:meteor/services/ActualCity.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await StreamingSharedPreferences.instance;
  final city = ActualCity(preferences);
  runApp(MyApp(city));
}

class MyApp extends StatelessWidget {
  MyApp(this.city, {Key? key}) : super(key: key);
  final ActualCity city;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(null, city),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
