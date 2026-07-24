import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../settings/controller_settings.dart';

class CalibrationPage extends StatefulWidget {
  const CalibrationPage({super.key});

  @override
  State<CalibrationPage> createState() =>
      _CalibrationPageState();
}

class _CalibrationPageState
    extends State<CalibrationPage> {

  double currentValue = 0.0;

  late StreamSubscription<AccelerometerEvent>
      accelerometerSubscription;

  @override
  void initState() {
    super.initState();

    accelerometerSubscription =
        accelerometerEventStream().listen(
              (event) {

            setState(() {
              currentValue = event.y;
            });

          },
        );
  }

  Future<void> calibrateSteering() async {

    await ControllerSettings
        .setSteeringOffset(currentValue);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(

      const SnackBar(
        content:
        Text("Calibration Successful!"),
        duration: Duration(seconds: 1),
      ),

    );

    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    accelerometerSubscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.black,

      appBar: AppBar(
        title:
        const Text("Steering Calibration"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),

      body: Center(

        child: Padding(

          padding:
          const EdgeInsets.all(24),

          child: Column(

            mainAxisAlignment:
            MainAxisAlignment.center,

            children: [

              const Text(
                "Place your phone in the\n"
                "position you want to use\n"
                "for straight steering.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 40),

              Text(
                "Current Value\n"
                "${currentValue.toStringAsFixed(2)}",

                textAlign: TextAlign.center,

                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                "Saved Value\n"
                "${ControllerSettings.getSteeringOffset().toStringAsFixed(2)}",

                textAlign: TextAlign.center,

                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 50),

              ElevatedButton(

                onPressed: () {
                  calibrateSteering();
                },

                child: const Text(
                  "CALIBRATE",
                ),

              ),

            ],

          ),

        ),

      ),

    );

  }
}