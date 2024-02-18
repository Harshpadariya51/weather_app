// import 'package:flutter/material.dart';
// import 'package:weather_app/provider/provider_weather.dart';
//
// class Home_Page extends StatefulWidget {
//   // final weathermodel weather;
//   Home_Page({
//     super.key,
//   });
//
//   @override
//   State<Home_Page> createState() => _Home_PageState();
// }
//
// class _Home_PageState extends State<Home_Page> {
//   final WeatherProvider weatherProvider = WeatherProvider();
//   late List<String> savedLocations = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         image: DecorationImage(
//             image: AssetImage('assets/img/Starry_Mountain.jpg'),
//             fit: BoxFit.cover),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         extendBodyBehindAppBar: true,
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           title: const Text(
//             "Weather App",
//             style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//           ),
//           centerTitle: true,
//         ),
//         body: ListView(
//           children: [
//             Container(
//               height: 400,
//               color: Colors.blue,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/provider/provider_weather.dart';
import 'package:weather_app/views/screen/weather_detail.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home_Page>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late TextEditingController searchController = TextEditingController();
  final WeatherProvider weatherProvider = WeatherProvider();
  late List<String> savedLocations = [];

  Future<void> saveLocation(String location) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedLocations = prefs.getStringList('savedLocations') ?? [];
    savedLocations.add(location);
    await prefs.setStringList('savedLocations', savedLocations);
  }

  Future<List<String>> getSavedLocations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('savedLocations') ?? [];
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    loadSavedLocations();
    _animationController.repeat(reverse: true);
  }

  Future<void> loadSavedLocations() async {
    savedLocations = await getSavedLocations();
    setState(() {});
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/img/Starry_Mountain.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text(
                'Weather App',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              expandedHeight: 70,
            ),
            SliverPadding(
              padding: const EdgeInsets.all(8),
              sliver: SliverToBoxAdapter(
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelText: 'City/Country',
                    hintText: 'Search for a City/Country',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white60)),
                    labelStyle: const TextStyle(color: Colors.white70),
                    contentPadding: const EdgeInsets.all(8),
                    // isDense: true,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        weatherProvider.fetchWeatherData(searchController.text);
                        saveLocation(searchController.text);
                        loadSavedLocations();
                      },
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      weatherProvider.weather == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FadeTransition(
                                  opacity: _animation,
                                  child: const Text(
                                    "Data not available",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            )
                          : WeatherInfo(
                              weather: weatherProvider.weather!,
                            ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
