import 'package:flutter/material.dart';


class XboxMappingDialog extends StatelessWidget {


  final List<String> usedMappings;


  const XboxMappingDialog({

    super.key,

    required this.usedMappings,

  });



  final List<String> xboxButtons = const [

    "A",

    "B",

    "X",

    "Y",

    "LB",

    "RB",

    "LEFT_STICK",

    "RIGHT_STICK",

    "DPAD_UP",

    "DPAD_DOWN",

    "DPAD_LEFT",

    "DPAD_RIGHT",

    "VIEW",

    "MENU",

  ];





  String displayName(String button) {


    switch(button) {


      case "LEFT_STICK":
        return "Left Stick Click";


      case "RIGHT_STICK":
        return "Right Stick Click";


      case "DPAD_UP":
        return "D-Pad Up";


      case "DPAD_DOWN":
        return "D-Pad Down";


      case "DPAD_LEFT":
        return "D-Pad Left";


      case "DPAD_RIGHT":
        return "D-Pad Right";


      case "VIEW":
        return "View";


      case "MENU":
        return "Menu";


      default:
        return button;

    }

  }





  @override
  Widget build(BuildContext context) {


    final availableButtons =
        xboxButtons
            .where(
              (button) =>
                  !usedMappings.contains(button),
            )
            .toList();




    return AlertDialog(


      backgroundColor: Colors.black87,



      title:

          const Text(

            "Select Xbox Button",

            style:

                TextStyle(

                  color: Colors.white,

                ),

          ),




      content:

          SizedBox(

            width: 300,


            height: 400,


            child:

                ListView.builder(

                  itemCount:
                      availableButtons.length,


                  itemBuilder:
                      (context,index) {


                    return Padding(

                      padding:

                          const EdgeInsets.symmetric(

                            vertical: 5,

                          ),



                      child:

                          ElevatedButton(


                            onPressed: () {


                              Navigator.pop(

                                context,

                                availableButtons[index],

                              );


                            },


                            child:

                                Text(

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

              ),


        ),


      ],



    );


  }


}