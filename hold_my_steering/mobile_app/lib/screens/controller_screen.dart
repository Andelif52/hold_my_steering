import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:async';
import 'dart:ui';
import 'package:sensors_plus/sensors_plus.dart';
import '../settings/controller_settings.dart';

class ControllerScreen extends StatefulWidget {
  final Socket socket;

  const ControllerScreen({super.key, required this.socket});

  @override
  State<ControllerScreen> createState() => _ControllerScreenState();
}

class _ControllerScreenState extends State<ControllerScreen> {
  double brakeStartY = 0;
  double throttleStartY = 0;

  double brakePercentage = 0;
  double throttlePercentage = 0;

  double get steeringSensitivity =>
      ControllerSettings.steeringSensitivity / 100;

  late StreamSubscription<AccelerometerEvent>
      accelerometerSubscription;

  // Swipe Sensitivity

  double getMaxSwipeDistance() {
    double sensitivity =
        ControllerSettings.getSwipeSensitivity();

    // Convert 25%-100% into 0.0-1.0.
    double normalizedValue =
        (sensitivity - 25) / 75;

    // 25% = 400 pixels
    // 100% = 100 pixels
    return lerpDouble(
      400,
      100,
      normalizedValue,
    )!
        .toDouble();
  }

  int calculatePercentage(
    double startY,
    double currentY,
  ) {
    double distance = startY - currentY;

    double percentage =
        (distance / getMaxSwipeDistance()) * 100;

    percentage = percentage.clamp(0, 100);

    return percentage.toInt();
  }

  int calculateSteering(double yValue) {
    const double maximumSensorValue = 10;
    const double maximumSteeringAngle = 95.0;

    print(yValue);

    // Convert sensor value into steering angle.
    double steeringAngle =
        (yValue / maximumSensorValue) *
            maximumSteeringAngle;

    // Apply steering sensitivity.
    steeringAngle *= steeringSensitivity;

    // Maximum steering angle is fixed.
    // steeringAngle =
    // steeringAngle.clamp(-90.0, 90.0);

    return steeringAngle.round();
  }

  @override
  void initState() {
    super.initState();

    print("ControllerScreen initState called");

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    accelerometerSubscription =
        accelerometerEventStream().listen(
              (event) {
            double yValue = event.y;

            // Apply calibration only if available.

            if (ControllerSettings.getCalibrationStatus()) {
              yValue = yValue -
                  ControllerSettings.getSteeringOffset();
            }

            int steering =
            calculateSteering(yValue);

            print("STEER: $steering");

            widget.socket.write(
                "STEER:$steering\n");
          },
        );
  }

  @override
  void dispose() {
    accelerometerSubscription.cancel();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Row(
          children: [

            // LEFT HALF = BRAKE

            Expanded(
              child: GestureDetector(
                onVerticalDragStart: (details) {
                  brakeStartY =
                      details.localPosition.dy;
                },

                onVerticalDragUpdate: (details) {
                  int percentage =
                  calculatePercentage(
                    brakeStartY,
                    details.localPosition.dy,
                  );

                  setState(() {
                    brakePercentage =
                        percentage.toDouble();
                  });

                  widget.socket.write(
                      "BRAKE:$percentage\n");
                },

                onVerticalDragEnd: (_) {
                  setState(() {
                    brakePercentage = 0;
                  });

                  widget.socket.write(
                      "BRAKE:0\n");
                },

                child: Stack(
                  children: [
                    Container(
                        color: Colors.black),

                    Align(
                      alignment:
                      Alignment.bottomCenter,
                      child: AnimatedContainer(
                        duration:
                        const Duration(
                          milliseconds: 100,
                        ),

                        width:
                        double.infinity,

                        height:
                        MediaQuery.of(context)
                            .size
                            .height *
                            (brakePercentage / 100),

                        color: Colors.red
                            .withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // RIGHT HALF = THROTTLE

            Expanded(
              child: GestureDetector(
                onVerticalDragStart: (details) {
                  throttleStartY =
                      details.localPosition.dy;
                },

                onVerticalDragUpdate: (details) {
                  int percentage =
                  calculatePercentage(
                    throttleStartY,
                    details.localPosition.dy,
                  );

                  setState(() {
                    throttlePercentage =
                        percentage.toDouble();
                  });

                  widget.socket.write(
                      "THROTTLE:$percentage\n");
                },

                onVerticalDragEnd: (_) {
                  setState(() {
                    throttlePercentage = 0;
                  });

                  widget.socket.write(
                      "THROTTLE:0\n");
                },

                child: Stack(
                  children: [
                    Container(
                        color: Colors.black),

                    Align(
                      alignment:
                      Alignment.bottomCenter,
                      child: AnimatedContainer(
                        duration:
                        const Duration(
                          milliseconds: 100,
                        ),

                        width:
                        double.infinity,

                        height:
                        MediaQuery.of(context)
                            .size
                            .height *
                            (throttlePercentage / 100),

                        color: Colors.green
                            .withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}