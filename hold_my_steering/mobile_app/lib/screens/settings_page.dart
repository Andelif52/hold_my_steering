import 'package:flutter/material.dart';
import '../settings/controller_settings.dart';
import 'calibration_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<int> steeringValues = [];
  List<int> swipeValues = [];

  List<int> analogDeadZoneValues = [];

  List<int> analogSensitivityValues = [];

  @override
  void initState() {
    super.initState();

    for (int i = 50; i <= 200; i += 10) {
      steeringValues.add(i);
    }

    for (int i = 25; i <= 100; i += 5) {
      swipeValues.add(i);
    }

    for (int i = 0; i <= 30; i += 5) {
      analogDeadZoneValues.add(i);
    }

    for (int i = 50; i <= 200; i += 10) {
      analogSensitivityValues.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),

      body: ListView(
        children: [
          // Steering Sensitivity
          ListTile(
            title: const Text(
              "Steering Sensitivity",
              style: TextStyle(color: Colors.white),
            ),

            subtitle: Text(
              "${ControllerSettings.steeringSensitivity}%",
              style: const TextStyle(color: Colors.grey),
            ),

            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),

            onTap: () {
              showModalBottomSheet(
                context: context,

                builder: (context) {
                  return ListView.builder(
                    itemCount: steeringValues.length,

                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text("${steeringValues[index]}%"),

                        onTap: () async {
                          await ControllerSettings.setSteeringSensitivity(
                            steeringValues[index],
                          );

                          setState(() {});

                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
              );
            },
          ),

          const Divider(),

          // Swipe Sensitivity
          ListTile(
            title: const Text(
              "Swipe Sensitivity",
              style: TextStyle(color: Colors.white),
            ),

            subtitle: Text(
              "${ControllerSettings.swipeSensitivity.round()}%",
              style: const TextStyle(color: Colors.grey),
            ),

            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),

            onTap: () {
              showModalBottomSheet(
                context: context,

                builder: (context) {
                  return ListView.builder(
                    itemCount: swipeValues.length,

                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text("${swipeValues[index]}%"),

                        onTap: () async {
                          await ControllerSettings.setSwipeSensitivity(
                            swipeValues[index].toDouble(),
                          );

                          setState(() {});

                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
              );
            },
          ),

                    const Divider(),

          // Analog Dead Zone
          ListTile(
            title: const Text(
              "Analog Dead Zone",
              style: TextStyle(color: Colors.white),
            ),

            subtitle: Text(
              "${ControllerSettings.analogDeadZone.round()}%",
              style: const TextStyle(color: Colors.grey),
            ),

            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),

            onTap: () {
              showModalBottomSheet(
                context: context,

                builder: (context) {
                  return ListView.builder(
                    itemCount: analogDeadZoneValues.length,

                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          "${analogDeadZoneValues[index]}%",
                        ),

                        onTap: () async {
                          await ControllerSettings
                              .setAnalogDeadZone(
                            analogDeadZoneValues[index]
                                .toDouble(),
                          );

                          setState(() {});

                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
              );
            },
          ),


          const Divider(),


          // Analog Sensitivity
          ListTile(
            title: const Text(
              "Analog Sensitivity",
              style: TextStyle(color: Colors.white),
            ),

            subtitle: Text(
              "${ControllerSettings.analogSensitivity.round()}%",
              style: const TextStyle(color: Colors.grey),
            ),

            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),

            onTap: () {
              showModalBottomSheet(
                context: context,

                builder: (context) {
                  return ListView.builder(
                    itemCount: analogSensitivityValues.length,

                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          "${analogSensitivityValues[index]}%",
                        ),

                        onTap: () async {
                          await ControllerSettings
                              .setAnalogSensitivity(
                            analogSensitivityValues[index]
                                .toDouble(),
                          );

                          setState(() {});

                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
              );
            },
          ),


          const Divider(),



          // Steering Calibration
          ListTile(
            title: const Text(
              "Steering Calibration",
              style: TextStyle(color: Colors.white),
            ),

            subtitle: Text(
              ControllerSettings.getCalibrationStatus()
                  ? "Calibrated"
                  : "Not Calibrated",
              style: const TextStyle(color: Colors.grey),
            ),

            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),

            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CalibrationPage()),
              );

              // Refresh the page after returning.

              setState(() {});
            },
          ),
        ],
      ),
    );
  }




}
