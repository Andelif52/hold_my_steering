import 'package:flutter/material.dart';
import 'screens/landing_page.dart';
import 'settings/controller_settings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ControllerSettings.loadCalibration();

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