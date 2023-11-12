import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeatherForecast extends StatefulWidget {
  const WeatherForecast({super.key, required this.additionalData});
  final List<dynamic> additionalData;

  @override
  State<WeatherForecast> createState() {
    return _WeatherForecastState();
  }
}

class _WeatherForecastState extends State<WeatherForecast> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.additionalData.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => SizedBox(
        width: 100,
        child: Card(
          elevation: 4,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(DateFormat('dd MMM\nhh:mm a').format(
                    DateTime.fromMillisecondsSinceEpoch(
                        widget.additionalData[index]["dt"] * 1000))),
                Icon(
                  widget.additionalData[index]["weather"][0]["main"] == "Clear"
                      ? Icons.sunny
                      : Icons.cloud,
                  color: widget.additionalData[index]['weather'][0]["main"] ==
                          "Clear"
                      ? Colors.yellow
                      : Colors.white,
                ),
                Text(
                  "${widget.additionalData[index]["main"]["temp"].toString()} °C",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
