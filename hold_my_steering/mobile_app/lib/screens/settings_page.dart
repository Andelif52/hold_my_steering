import 'package:flutter/material.dart';
import '../settings/controller_settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  List<int> steeringValues = [];

  @override
  void initState() {
    super.initState();

    for(int i = 50 ; i <= 200 ; i += 10){
      steeringValues.add(i);
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

          const ListTile(

            title: Text(
              "Swipe Sensitivity",
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

          const Divider(),

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