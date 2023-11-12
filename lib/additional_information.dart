import 'package:flutter/material.dart';
import 'package:weather_app/bottom_line.dart';

class AdditionalInformation extends StatefulWidget {
  const AdditionalInformation({super.key, required this.hwp});

  final Map<String, dynamic> hwp;

  @override
  State<AdditionalInformation> createState() {
    return _AdditionalInformationState();
  }
}

class _AdditionalInformationState extends State<AdditionalInformation> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BottomLine(
          value: widget.hwp["main"]["humidity"].toString(),
          icon: Icons.water_drop,
          text: "Humidity",
          color: Colors.blue.shade300,
        ),
        BottomLine(
          value: widget.hwp["main"]["pressure"].toString(),
          icon: Icons.beach_access,
          text: "Pressure",
        ),
        BottomLine(
          value: widget.hwp["wind"]["speed"].toString(),
          icon: Icons.wind_power,
          text: "Wind",
        ),
      ],
    );
  }
}
