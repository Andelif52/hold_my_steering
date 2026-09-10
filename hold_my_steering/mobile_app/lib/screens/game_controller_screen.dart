import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/controller_layout.dart';
import '../services/layout_storage.dart';
import '../services/default_layout_generator.dart';

import '../widgets/xbox_abxy_button.dart';
import '../widgets/analog_stick.dart';
import '../widgets/dpad.dart';

class GameControllerScreen extends StatefulWidget {
  final Socket socket;

  const GameControllerScreen({super.key, required this.socket});

  @override
  State<GameControllerScreen> createState() => _GameControllerScreenState();
}

class _GameControllerScreenState extends State<GameControllerScreen> {
  ControllerLayout? layout;

  bool loading = true;

  double screenWidth = 0;

  double screenHeight = 0;

  bool layoutLoadingStarted = false;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  Future<void> loadLayout() async {
    await Future.delayed(const Duration(milliseconds: 500));

    ControllerLayout? loadedLayout;

    final currentLayout = await LayoutStorage.getCurrentLayout();

    if (currentLayout != null) {
      loadedLayout = await LayoutStorage.loadLayout(currentLayout);
    }

    if (loadedLayout == null) {
      loadedLayout = DefaultLayoutGenerator.create(screenWidth, screenHeight);
    }

    if (!mounted) {
      return;
    }

    setState(() {
      layout = loadedLayout;

      loading = false;
    });
  }

  void sendButtonCommand(String button, bool pressed) {
    widget.socket.write("$button:${pressed ? 1 : 0}\n");
  }

  Widget buildButton(ControllerButton button) {
    switch (button.type) {
      case "A":
      case "B":
      case "X":
      case "Y":
        return XboxABXYButton(
          label: button.type,

          size: button.size,

          opacity: button.opacity,

          selected: false,
        );

      case "LEFT_STICK":
      case "RIGHT_STICK":
        return AnalogStick(
          size: button.size,

          opacity: button.opacity,

          selected: false,

          interactive: true,

          onMove: (x, y) {
            widget.socket.write("${button.type}_X:${x.round()}\n");

            widget.socket.write("${button.type}_Y:${y.round()}\n");
          },

          onRelease: () {
            widget.socket.write("${button.type}_X:0\n");

            widget.socket.write("${button.type}_Y:0\n");
          },
        );

      case "DPAD":
        return DPad(
          size: button.size,

          opacity: button.opacity,

          selected: false,

          onDirection: (direction, pressed) {
            widget.socket.write("DPAD_$direction:${pressed ? 1 : 0}\n");
          },
        );

      case "LB":
      case "RB":
      case "LT":
      case "RT":
        return Opacity(
          opacity: button.opacity,

          child: Container(
            width: button.size,

            height: button.size / 2,

            decoration: BoxDecoration(
              color: Colors.black87,

              borderRadius: BorderRadius.circular(15),

              border: Border.all(color: Colors.white, width: 3),
            ),

            child: Center(
              child: Text(
                button.type,

                style: const TextStyle(
                  color: Colors.white,

                  fontSize: 20,

                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );

      case "VIEW":
      case "MENU":
        return Opacity(
          opacity: button.opacity,

          child: Container(
            width: button.size,

            height: button.size,

            decoration: BoxDecoration(
              shape: BoxShape.circle,

              color: Colors.black87,

              border: Border.all(color: Colors.white, width: 2),
            ),

            child: Center(
              child: Text(
                button.type == "VIEW" ? "≡" : "☰",

                style: const TextStyle(
                  color: Colors.white,

                  fontSize: 18,

                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );

      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: LayoutBuilder(
        builder: (context, constraints) {
          screenWidth = constraints.maxWidth;

          screenHeight = constraints.maxHeight;

          if (!layoutLoadingStarted) {
            layoutLoadingStarted = true;

            WidgetsBinding.instance.addPostFrameCallback((_) {
              loadLayout();
            });
          }

          return loading || layout == null
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: Stack(
                    children: [
                      ...layout!.buttons.map((button) {
                        return Positioned(
                          left: button.x,

                          top: button.y,

                          child:
                              (button.type == "LEFT_STICK" ||
                                  button.type == "RIGHT_STICK")
                              ? buildButton(button)
                              : GestureDetector(
                                  onTapDown: (_) {
                                    sendButtonCommand(button.type, true);
                                  },

                                  onTapUp: (_) {
                                    sendButtonCommand(button.type, false);
                                  },

                                  onTapCancel: () {
                                    sendButtonCommand(button.type, false);
                                  },

                                  child: buildButton(button),
                                ),
                        );
                      }),

                      Positioned(
                        top: 5,

                        right: 5,

                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,

                            color: Colors.white,

                            size: 28,
                          ),

                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    super.dispose();
  }
}
