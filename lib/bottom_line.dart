import 'package:flutter/material.dart';

class BottomLine extends StatelessWidget {
  const BottomLine(
      {super.key,
      required this.value,
      required this.icon,
      required this.text,
      this.color = Colors.white});
  final String value;
  final IconData icon;
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 120,
        child: Card(
          elevation: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                size: 40,
                color: color,
              ),
              Text(text),
              Text(value),
            ],
          ),
        ),
      ),
    );
  }
}
