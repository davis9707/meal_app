import 'package:flutter/material.dart';

class MealItemSpec extends StatelessWidget {
  const MealItemSpec({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 17,
        ),
        SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}