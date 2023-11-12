import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/additional_information.dart';
import 'package:weather_app/weather_forecast_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  final _cityController = TextEditingController();

  String apiLink =
      "https://api.openweathermap.org/data/2.5/forecast?q=multan&units=metric&appid=d05dc52a0ea172d5398062326cfa6f22";

  Future<Map<String, dynamic>> _fetchingWeathersData(String apiLink) async {
    final response = await http.get(
      Uri.parse(
        apiLink,
      ),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json;
    } else {
      throw "Enable to Fetch data";
    }
  }

  // late Future<Map<String, dynamic>> weatherFuture;

  // @override
  // void initState() {
  //   super.initState();
  //   weatherFuture = _fetchingWeathersData();
  // }

  void _refreshWeather() {
    // print("Fetch weather func is running");
    setState(() {
      _fetchingWeathersData(apiLink);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Morning"),
        actions: [
          IconButton(
            onPressed: () {
              _refreshWeather();
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: _fetchingWeathersData(apiLink),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: Text("No data Found"),
              );
            }
            final _data = snapshot.data!;
            final _currentTemperature = _data["list"][0]["main"]["temp"];
            final _weather = _data["list"][0]["weather"][0]["main"];
            final _listData = _data["list"];
            final _dataHWP = _data["list"][0];

            return Container(
              child: Column(
                children: [
                  SizedBox(
                    width: 380,
                    child: TextField(
                      controller: _cityController,
                      onSubmitted: (value) {
                        if (value != "") {
                          apiLink =
                              "https://api.openweathermap.org/data/2.5/forecast?q=$value&units=metric&appid=d05dc52a0ea172d5398062326cfa6f22";
                        } else {
                          apiLink =
                              "https://api.openweathermap.org/data/2.5/forecast?q=multan&units=metric&appid=d05dc52a0ea172d5398062326cfa6f22";
                        }
                        setState(
                          () {
                            _fetchingWeathersData(apiLink);
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 220,
                    child: Card(
                      shadowColor: Colors.black,
                      color: const Color.fromARGB(255, 74, 74, 74),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 7),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(18),
                        ),
                      ),
                      elevation: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "${_currentTemperature.toString()} °C",
                            style: const TextStyle(fontSize: 25),
                          ),
                          Icon(
                            _weather == "Clouds" ? Icons.cloud : Icons.sunny,
                            color: _weather == "Clear"
                                ? Colors.yellow
                                : Colors.white,
                            size: 100,
                          ),
                          Text(
                            _weather == "Clouds" ? "Clouds" : "Sunny",
                            style: const TextStyle(fontSize: 25),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Text(
                    "Weather Forecast",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 140,
                    child: Expanded(
                      child: WeatherForecast(
                        additionalData: _listData,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Additional Information",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AdditionalInformation(hwp: _dataHWP),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
