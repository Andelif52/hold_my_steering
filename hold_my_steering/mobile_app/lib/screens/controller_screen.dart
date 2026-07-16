import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';

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

  late StreamSubscription<AccelerometerEvent> accelerometerSubscription;

  static const double maxSwipeDistance = 250;

  int calculatePercentage(double startY, double currentY) {
    double distance = startY - currentY;

    double percentage = (distance / maxSwipeDistance) * 100;

    percentage = percentage.clamp(0, 100);

    return percentage.toInt();
  }

  int calculateSteering(double y) {
    double steering = (y / 9.5) * 100;

    steering = steering.clamp(-100, 100);

    // Dead zone
    if (steering.abs() < 10) {
      steering = 0;
    }

    return steering.toInt();
  }

  @override
  void initState() {
    super.initState();

    print("ControllerScreen initState called");

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    accelerometerSubscription = accelerometerEventStream().listen((event) {
      int steering = calculateSteering(event.y);

      print("STEER: $steering");

      widget.socket.write("STEER:$steering\n");
    });
  }

  @override
  void dispose() {
    accelerometerSubscription.cancel();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

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
                  brakeStartY = details.localPosition.dy;
                },
                onVerticalDragUpdate: (details) {
                  int percentage = calculatePercentage(
                    brakeStartY,
                    details.localPosition.dy,
                  );

                  setState(() {
                    brakePercentage = percentage.toDouble();
                  });

                  widget.socket.write("BRAKE:$percentage\n");
                },
                onVerticalDragEnd: (_) {
                  setState(() {
                    brakePercentage = 0;
                  });

                  widget.socket.write("BRAKE:0\n");
                },
                child: Stack(
                  children: [
                    Container(color: Colors.black),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        width: double.infinity,
                        height:
                            MediaQuery.of(context).size.height *
                            (brakePercentage / 100),
                        color: Colors.red.withOpacity(0.7),
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
                  throttleStartY = details.localPosition.dy;
                },
                onVerticalDragUpdate: (details) {
                  int percentage = calculatePercentage(
                    throttleStartY,
                    details.localPosition.dy,
                  );

                  setState(() {
                    throttlePercentage = percentage.toDouble();
                  });

                  widget.socket.write("THROTTLE:$percentage\n");
                },
                onVerticalDragEnd: (_) {
                  setState(() {
                    throttlePercentage = 0;
                  });

                  widget.socket.write("THROTTLE:0\n");
                },
                child: Stack(
                  children: [
                    Container(color: Colors.black),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        width: double.infinity,
                        height:
                            MediaQuery.of(context).size.height *
                            (throttlePercentage / 100),
                        color: Colors.green.withOpacity(0.7),
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
