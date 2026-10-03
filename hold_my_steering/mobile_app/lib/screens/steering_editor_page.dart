import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/steering_layout.dart';

import '../services/steering_layout_storage.dart';

import '../widgets/steering_button.dart';
import '../widgets/add_steering_button_dialog.dart';
import '../widgets/steering_editor_control_panel.dart';
import '../widgets/steering_layout_control_panel.dart';
import '../widgets/save_steering_layout_dialog.dart';
import '../widgets/xbox_mapping_dialog.dart';

class SteeringEditorPage extends StatefulWidget {
  final SteeringLayout? existingLayout;

  const SteeringEditorPage({super.key, this.existingLayout});

  @override
  State<SteeringEditorPage> createState() => _SteeringEditorPageState();
}

class _SteeringEditorPageState extends State<SteeringEditorPage> {
  SteeringLayout? layout;

  SteeringButton? selectedButton;

  double screenWidth = 0;

  double screenHeight = 0;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,

      DeviceOrientation.landscapeRight,
    ]);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    super.dispose();
  }

  void createLayout() {
    if (layout != null) return;

    if (widget.existingLayout != null) {
      layout = widget.existingLayout;
    } else {
      layout = SteeringLayout(
        name: "New Steering",

        buttons: [
          SteeringButton(
            type: "BRAKE",

            x: 0,

            y: 0,

            size: 0,

            opacity: 1,

            visible: true,

            editable: false,
          ),

          SteeringButton(
            type: "THROTTLE",

            x: screenWidth / 2,

            y: 0,

            size: 0,

            opacity: 1,

            visible: true,

            editable: false,
          ),

          SteeringButton(
            type: "TILT",

            x: 0.5,

            y: 0.5,

            size: 100,

            opacity: 1,

            visible: true,

            editable: false,
          ),
        ],
      );
    }
  }

  Future<void> addButton() async {
    final type = await showDialog<String>(
      context: context,

      builder: (context) => AddSteeringButtonDialog(
        existingButtons: layout!.buttons.map((button) => button.type).toList(),
      ),
    );

    if (type == null) return;

    final button = SteeringButton(
      type: type,

      x: 0.5,

      y: 0.5,

      size: 80,

      opacity: 1,

      visible: true,
    );

    setState(() {
      layout!.buttons.add(button);

      selectedButton = button;
    });
  }

  void moveButton(SteeringButton button, DragUpdateDetails details) {
    if (!button.editable) return;

    setState(() {
      double newX = (button.x * screenWidth) + details.delta.dx;

      double newY = (button.y * screenHeight) + details.delta.dy;

      if (newX < 0) {
        newX = 0;
      }

      if (newY < 0) {
        newY = 0;
      }

      if (newX + button.size > screenWidth) {
        newX = screenWidth - button.size;
      }

      if (newY + button.size > screenHeight) {
        newY = screenHeight - button.size;
      }

      button.x = newX / screenWidth;

      button.y = newY / screenHeight;
    });
  }

  Future<void> saveLayout() async {
    final name = await showDialog<String>(
      context: context,

      builder: (context) => const SaveSteeringLayoutDialog(),
    );

    if (name == null || name.isEmpty) {
      return;
    }

    layout!.name = name;

    await SteeringLayoutStorage.saveLayout(layout!);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("$name saved")));
  }

  Widget buildFixedButton(SteeringButton button) {
    if (button.type == "BRAKE") {
      return Align(
        alignment: Alignment.centerLeft,

        child: Container(
          width: screenWidth / 2,

          color: Colors.red.withOpacity(0.3),
        ),
      );
    }

    if (button.type == "THROTTLE") {
      return Align(
        alignment: Alignment.centerRight,

        child: Container(
          width: screenWidth / 2,

          color: Colors.green.withOpacity(0.3),
        ),
      );
    }

    if (button.type == "TILT") {
      return const Icon(
        Icons.stay_current_landscape,

        color: Colors.white,

        size: 80,
      );
    }

    return const SizedBox();
  }

  Future<void> mapXboxButton() async {
    final usedMappings = layout!.buttons
        .where(
          (button) => button.xboxMapping != null && button != selectedButton,
        )
        .map((button) => button.xboxMapping!)
        .toList();

    final mapping = await showDialog<String>(
      context: context,

      builder: (context) => XboxMappingDialog(usedMappings: usedMappings),
    );

    if (mapping != null) {
      setState(() {
        selectedButton!.xboxMapping = mapping;
      });
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

          createLayout();

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedButton = null;
              });
            },

            child: Stack(
              children: [
                ...layout!.buttons.map((button) {
                  if (!button.editable) {
                    return Positioned.fill(child: buildFixedButton(button));
                  }

                  return Positioned(
                    left: button.x * screenWidth,

                    top: button.y * screenHeight,

                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedButton = button;
                        });
                      },

                      onPanUpdate: (details) {
                        moveButton(button, details);
                      },

                      child: SteeringButtonWidget(
                        type: button.type,

                        size: button.size,

                        opacity: button.opacity,

                        selected: selectedButton == button,
                      ),
                    ),
                  );
                }),

                if (selectedButton != null)
                  Positioned(
                    top: 20,

                    left: screenWidth / 2 - 150,

                    child: SteeringEditorControlPanel(
                      sizeValue: selectedButton!.size,

                      opacityValue: selectedButton!.opacity,

                      buttonType: selectedButton!.type,

                      currentMapping: selectedButton!.xboxMapping,

                      onSizeChanged: (value) {
                        setState(() {
                          selectedButton!.size = value;
                        });
                      },

                      onOpacityChanged: (value) {
                        setState(() {
                          selectedButton!.opacity = value;
                        });
                      },

                      onMapXbox: mapXboxButton,

                      onRemove: () {
                        setState(() {
                          layout!.buttons.remove(selectedButton);

                          selectedButton = null;
                        });
                      },
                    ),
                  ),

                Positioned(
                  bottom: 20,

                  left: screenWidth / 2 - 130,

                  child: SteeringLayoutControlPanel(
                    onAddButton: addButton,

                    onSaveLayout: saveLayout,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
