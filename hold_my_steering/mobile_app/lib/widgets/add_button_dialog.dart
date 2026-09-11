import 'package:flutter/material.dart';

class AddButtonDialog extends StatelessWidget {
  final List<String> availableButtons;

  const AddButtonDialog({super.key, required this.availableButtons});

  String getDisplayName(String type) {
    switch (type) {
      case "LEFT_STICK":
        return "Left Stick";

      case "RIGHT_STICK":
        return "Right Stick";

      case "DPAD":
        return "D-Pad";

      case "VIEW":
        return "View Button";

      case "MENU":
        return "Menu Button";

      case "SWITCH":
        return "Switch Button";

      default:
        return type;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black87,

      title: const Text(
        "Add Controller Button",

        style: TextStyle(color: Colors.white),
      ),

      content: SizedBox(
        width: 300,

        child: availableButtons.isEmpty
            ? const Text(
                "All buttons are already added.",

                style: TextStyle(color: Colors.white),
              )
            : ListView.builder(
                shrinkWrap: true,

                itemCount: availableButtons.length,

                itemBuilder: (context, index) {
                  final button = availableButtons[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),

                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, button);
                      },

                      child: Text(
                        getDisplayName(button),

                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  );
                },
              ),
      ),

      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },

          child: const Text("Cancel", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
