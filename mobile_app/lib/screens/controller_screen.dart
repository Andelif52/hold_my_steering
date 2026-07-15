import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class ControllerScreen extends StatefulWidget {
  final Socket socket;

  const ControllerScreen({
    super.key,
    required this.socket,
  });

  @override
  State<ControllerScreen> createState() => _ControllerScreenState();
}

class _ControllerScreenState extends State<ControllerScreen> {
  double brakeStartY = 0;
  double throttleStartY = 0;

  static const double maxSwipeDistance = 250;

  int calculatePercentage(double startY, double currentY) {
    double distance = startY - currentY;

    double percentage = (distance / maxSwipeDistance) * 100;

    percentage = percentage.clamp(0, 100);

    return percentage.toInt();
  }

  @override
  void initState() {
    super.initState();

    print("ControllerScreen initState called");

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
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
                  brakeStartY = details.localPosition.dy;
                },

                onVerticalDragUpdate: (details) {
                  int percentage = calculatePercentage(
                    brakeStartY,
                    details.localPosition.dy,
                  );

                  widget.socket.write(
                    "BRAKE:$percentage\n",
                  );
                },

                onVerticalDragEnd: (_) {
                  widget.socket.write("BRAKE:0\n");
                },

                child: Container(
                  color: Colors.black,
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

                  widget.socket.write(
                    "THROTTLE:$percentage\n",
                  );
                },

                onVerticalDragEnd: (_) {
                  widget.socket.write("THROTTLE:0\n");
                },

                child: Container(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}