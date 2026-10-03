import 'package:flutter/material.dart';


class AddSteeringButtonDialog extends StatelessWidget {


  final List<String> existingButtons;


  const AddSteeringButtonDialog({

    super.key,

    required this.existingButtons,

  });



  final List<String> allButtons = const [

    "NITRO",

    "HANDBRAKE",

    "GEAR_UP",

    "GEAR_DOWN",

    "CLUTCH",

  ];



  String displayName(String type) {

    switch(type) {

      case "NITRO":
        return "Nitro";

      case "HANDBRAKE":
        return "Handbrake";

      case "GEAR_UP":
        return "Gear Up";

      case "GEAR_DOWN":
        return "Gear Down";

      case "CLUTCH":
        return "Clutch";

      default:
        return type;

    }

  }




  @override
  Widget build(BuildContext context) {


    final availableButtons =
        allButtons
            .where(
              (button) =>
                  !existingButtons.contains(button),
            )
            .toList();



    return AlertDialog(

      backgroundColor: Colors.black87,


      title: const Text(

        "Add Steering Button",

        style:
            TextStyle(
              color: Colors.white,
            ),

      ),



      content: SizedBox(

        width: 300,


        child: availableButtons.isEmpty

            ? const Text(

                "All buttons added",

                style:
                    TextStyle(
                      color: Colors.white,
                    ),

              )


            : ListView.builder(

                shrinkWrap: true,

                itemCount: availableButtons.length,


                itemBuilder: (context,index) {


                  return Padding(

                    padding:
                        const EdgeInsets.symmetric(
                          vertical: 5,
                        ),


                    child: ElevatedButton(

                      onPressed: () {


                        Navigator.pop(

                          context,

                          availableButtons[index],

                        );


                      },


                      child: Text(

                        displayName(
                          availableButtons[index],
                        ),

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


          child:
              const Text(
                "Cancel",
                style:
                    TextStyle(
                      color: Colors.white,
                    ),
              ),

        ),

      ],


    );


  }


}