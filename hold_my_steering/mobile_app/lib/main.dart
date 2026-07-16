import 'package:flutter/material.dart';
import 'screens/landing_page.dart';

void main() {
  runApp(const HoldMySteeringApp());
}

class HoldMySteeringApp extends StatelessWidget {
  const HoldMySteeringApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hold My Steering',
      home: LandingPage(),
    );
  }
}