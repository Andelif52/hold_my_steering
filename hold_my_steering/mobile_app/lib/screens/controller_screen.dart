import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:async';
import 'dart:ui';

import 'package:sensors_plus/sensors_plus.dart';

import '../settings/controller_settings.dart';

import '../widgets/switch_button.dart';
import '../widgets/steering_button.dart';

import '../models/steering_layout.dart';
import '../services/steering_layout_storage.dart';

import 'game_controller_screen.dart';

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

  bool switchingScreen = false;

  double screenWidth = 0;
  double screenHeight = 0;

  SteeringLayout? steeringLayout;
  final Set<SteeringButton> pressedButtons = {};

  late StreamSubscription<AccelerometerEvent> accelerometerSubscription;

  double get steeringSensitivity =>
      ControllerSettings.steeringSensitivity / 100;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,

      DeviceOrientation.landscapeRight,
    ]);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    loadSteeringLayout();

    accelerometerSubscription = accelerometerEventStream().listen((event) {
      double yValue = event.y;

      if (ControllerSettings.getCalibrationStatus()) {
        yValue -= ControllerSettings.getSteeringOffset();
      }

      int steering = calculateSteering(yValue);

      widget.socket.write("STEER:$steering\n");
    });
  }

  Future<void> loadSteeringLayout() async {
    final currentLayout = await SteeringLayoutStorage.getCurrentLayout();

    if (currentLayout == null) {
      return;
    }

    final layout = await SteeringLayoutStorage.loadLayout(currentLayout);

    if (layout != null) {
      setState(() {
        steeringLayout = layout;
      });
    }
  }

  double getMaxSwipeDistance() {
    double sensitivity = ControllerSettings.getSwipeSensitivity();

    double normalizedValue = (sensitivity - 25) / 75;

    return lerpDouble(400, 100, normalizedValue)!.toDouble();
  }

  int calculatePercentage(double startY, double currentY) {
    double distance = startY - currentY;

    double percentage = (distance / getMaxSwipeDistance()) * 100;

    percentage = percentage.clamp(0, 100);

    return percentage.toInt();
  }

  int calculateSteering(double yValue) {
    const double maximumSensorValue = 10;

    const double maximumSteeringAngle = 95.0;

    double steeringAngle = (yValue / maximumSensorValue) * maximumSteeringAngle;

    steeringAngle *= steeringSensitivity;

    steeringAngle = steeringAngle.clamp(-90.0, 90.0);

    return steeringAngle.round();
  }

  void sendMappedButton(SteeringButton button, bool pressed) {
    if (button.xboxMapping == null) {
      return;
    }

    widget.socket.write("${button.xboxMapping}:${pressed ? 1 : 0}\n");
  }

  @override
  void dispose() {
    accelerometerSubscription.cancel();

    if (!switchingScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            screenWidth = constraints.maxWidth;
            screenHeight = constraints.maxHeight;

            return Stack(
              children: [
                Row(
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

                // CUSTOM STEERING BUTTONS ON TOP
                if (steeringLayout != null)
                  ...steeringLayout!.buttons
                      .where((button) => button.editable)
                      .map((button) {
                        return Positioned(
                          left: button.x * screenWidth,
                          top: button.y * screenHeight,

                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,

                            onTapDown: (_) {
                              setState(() {
                                pressedButtons.add(button);
                              });

                              sendMappedButton(button, true);
                            },

                            onTapUp: (_) {
                              setState(() {
                                pressedButtons.remove(button);
                              });

                              sendMappedButton(button, false);
                            },

                            onTapCancel: () {
                              setState(() {
                                pressedButtons.remove(button);
                              });

                              sendMappedButton(button, false);
                            },

                            child: SteeringButtonWidget(
                              type: button.type,

                              size: button.size,

                              opacity: button.opacity,

                              pressed: pressedButtons.contains(button),
                            ),
                          ),
                        );
                      }),

                // SWITCH BUTTON
                Positioned(
                  top: 20,

                  right: 20,

                  child: GestureDetector(
                    onTap: () {
                      switchingScreen = true;

                      Navigator.pushReplacement(
                        context,

                        MaterialPageRoute(
                          builder: (context) =>
                              GameControllerScreen(socket: widget.socket),
                        ),
                      );
                    },

                    child: const SwitchButton(size: 60, opacity: 1.0),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
