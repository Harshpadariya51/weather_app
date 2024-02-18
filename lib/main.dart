import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/provider_weather.dart';
import 'package:weather_app/views/Home/Home_page.dart';
import 'package:weather_app/views/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'splash_screen',
        routes: {
          '/': (context) => const Home_Page(),
          'splash_screen': (context) => const splash_screen(),
        },
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        themeMode: ThemeMode.system,
      ),
    );
  }
}
