import 'package:flutter/material.dart';
import '../settings/controller_settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  List<int> steeringValues = [];
  List<int> swipeValues = [];

  @override
  void initState() {
    super.initState();

    for (int i = 50; i <= 200; i += 10) {
      steeringValues.add(i);
    }

    for (int i = 25; i <= 100; i += 5) {
      swipeValues.add(i);
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
              style: TextStyle(
                color: Colors.white,
              ),
            ),

            subtitle: Text(
              "${ControllerSettings.steeringSensitivity}%",
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),

            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),

            onTap: () {

              showModalBottomSheet(

                context: context,

                builder: (context){

                  return ListView.builder(

                    itemCount: steeringValues.length,

                    itemBuilder: (context,index){

                      return ListTile(

                        title:
                        Text("${steeringValues[index]}%"),

                        onTap: (){

                          setState(() {

                            ControllerSettings
                                .steeringSensitivity =
                            steeringValues[index];

                          });

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
              style: TextStyle(
                color: Colors.white,
              ),
            ),

            subtitle: Text(
              "${ControllerSettings.swipeSensitivity.round()}%",
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),

            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),

            onTap: () {

              showModalBottomSheet(

                context: context,

                builder: (context){

                  return ListView.builder(

                    itemCount: swipeValues.length,

                    itemBuilder: (context,index){

                      return ListTile(

                        title:
                        Text("${swipeValues[index]}%"),

                        onTap: (){

                          setState(() {

                            ControllerSettings
                                .setSwipeSensitivity(
                                swipeValues[index].toDouble());

                          });

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

          const ListTile(

            title: Text(
              "Steering Calibration",
              style: TextStyle(
                color: Colors.white,
              ),
            ),

            subtitle: Text(
              "Coming Soon",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

          ),

        ],

      ),

    );
  }
}