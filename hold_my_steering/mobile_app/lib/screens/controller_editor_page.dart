import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/controller_layout.dart';
import '../services/default_layout_generator.dart';
import '../widgets/xbox_abxy_button.dart';
import '../widgets/analog_stick.dart';
import '../widgets/dpad.dart';
import '../widgets/editor_control_panel.dart';



class ControllerEditorPage extends StatefulWidget {

  const ControllerEditorPage({
    super.key,
  });


  @override
  State<ControllerEditorPage> createState() =>
      _ControllerEditorPageState();

}





class _ControllerEditorPageState
    extends State<ControllerEditorPage> {


  ControllerLayout? layout;


  ControllerButton? selectedButton;


  double screenWidth = 0;

  double screenHeight = 0;





  @override
  void initState() {

    super.initState();



    SystemChrome.setPreferredOrientations([

      DeviceOrientation.landscapeLeft,

      DeviceOrientation.landscapeRight,

    ]);



    SystemChrome.setEnabledSystemUIMode(

      SystemUiMode.immersiveSticky,

    );

  }






  @override
  void dispose() {


    SystemChrome.setEnabledSystemUIMode(

      SystemUiMode.edgeToEdge,

    );



    SystemChrome.setPreferredOrientations([


      DeviceOrientation.portraitUp,


      DeviceOrientation.portraitDown,


    ]);



    super.dispose();

  }







  void createLayoutIfReady() {


    if(layout != null) {

      return;

    }



    if(screenWidth <= screenHeight) {

      return;

    }



    layout =
        DefaultLayoutGenerator.create(

          screenWidth,

          screenHeight,

        );


  }








  Widget buildButton(
      ControllerButton button
      ) {


    bool isSelected =
        selectedButton == button;



    switch(button.type) {



      case "A":

      case "B":

      case "X":

      case "Y":


        return XboxABXYButton(

          label: button.type,

          size: button.size,

          opacity: button.opacity,

          selected: isSelected,

        );






      case "LEFT_STICK":

      case "RIGHT_STICK":


        return AnalogStick(

          size: button.size,

          opacity: button.opacity,

          selected: isSelected,

        );







      case "DPAD":


        return DPad(

          size: button.size,

          opacity: button.opacity,

          selected: isSelected,

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


              borderRadius:

                  BorderRadius.circular(15),



              border: Border.all(


                color: isSelected

                    ? Colors.yellow

                    : Colors.white,



                width: isSelected

                    ? 5

                    : 3,


              ),



            ),





            child: Center(


              child: Text(


                button.type,



                style: const TextStyle(


                  color: Colors.white,


                  fontSize: 20,


                  fontWeight:

                      FontWeight.bold,


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



             border: Border.all(


               color: isSelected

                   ? Colors.yellow

                   : Colors.white,


               width: isSelected

                   ? 4

                   : 2,


             ),



           ),



           child: Center(


             child: Text(


               button.type == "VIEW"

                   ? "≡"

                   : "☰",



               style: const TextStyle(


                 color: Colors.white,


                 fontSize: 18,


                 fontWeight:

                     FontWeight.bold,


               ),


             ),



           ),



         ),

       );






      default:

        return const SizedBox();


    }


  }








  void moveButton(
      ControllerButton button,
      DragUpdateDetails details,
      ) {


    setState(() {


      double newX =
          button.x + details.delta.dx;


      double newY =
          button.y + details.delta.dy;





      if(newX < 0) {

        newX = 0;

      }



      if(newY < 0) {

        newY = 0;

      }




      if(newX + button.size > screenWidth) {

        newX =
            screenWidth - button.size;

      }



      if(newY + button.size > screenHeight) {

        newY =
            screenHeight - button.size;

      }




      button.x = newX;


      button.y = newY;



    });


  }








  void removeSelectedButton() {


    if(selectedButton == null) {

      return;

    }



    setState(() {


      layout!.buttons.remove(selectedButton);


      selectedButton = null;


    });


  }









  @override
  Widget build(BuildContext context) {


    return Scaffold(


      backgroundColor: Colors.black87,



      body: LayoutBuilder(


        builder: (context,constraints) {



          screenWidth =
              constraints.maxWidth;



          screenHeight =
              constraints.maxHeight;



          createLayoutIfReady();





          if(layout == null) {


            return const SizedBox();

          }







          return GestureDetector(



            behavior:

                HitTestBehavior.opaque,



            onTap: () {


              setState(() {


                selectedButton = null;


              });


            },



            child: Stack(



              children: [




                ...layout!.buttons.map(



                  (button) {



                    return Positioned(



                      left: button.x,


                      top: button.y,



                      child: GestureDetector(



                        onTap: () {


                          setState(() {


                            selectedButton = button;


                          });


                        },



                        onPanStart: (_) {


                          setState(() {


                            selectedButton = button;


                          });


                        },



                        onPanUpdate: (details) {


                          moveButton(

                            button,

                            details,

                          );


                        },



                        child:

                            buildButton(button),



                      ),


                    );


                  },


                ),







                if(selectedButton != null)


                  Positioned(


                    top: 20,

                    left: screenWidth / 2 - 150,


                    child: EditorControlPanel(


                      sizeValue:

                          selectedButton!.size,



                      opacityValue:

                          selectedButton!.opacity,



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



                      onRemove:

                          removeSelectedButton,



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