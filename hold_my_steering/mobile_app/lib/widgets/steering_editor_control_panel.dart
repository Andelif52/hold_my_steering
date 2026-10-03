import 'package:flutter/material.dart';


class SteeringEditorControlPanel extends StatefulWidget {

  final double sizeValue;

  final double opacityValue;

  final String buttonType;

  final String? currentMapping;


  final Function(double) onSizeChanged;

  final Function(double) onOpacityChanged;

  final VoidCallback onMapXbox;

  final VoidCallback onRemove;



  const SteeringEditorControlPanel({

    super.key,

    required this.sizeValue,

    required this.opacityValue,

    required this.buttonType,

    required this.currentMapping,

    required this.onSizeChanged,

    required this.onOpacityChanged,

    required this.onMapXbox,

    required this.onRemove,

  });



  @override
  State<SteeringEditorControlPanel> createState() =>
      _SteeringEditorControlPanelState();

}




class _SteeringEditorControlPanelState
    extends State<SteeringEditorControlPanel> {


  bool expanded = true;



  @override
  Widget build(BuildContext context) {


    return AnimatedContainer(

      duration:
          const Duration(milliseconds: 250),


      width:
          expanded ? 330 : 60,


      height:
          expanded ? 180 : 50,



      decoration: BoxDecoration(

        color: Colors.black87,


        border:
            Border.all(
              color: Colors.white,
              width: 2,
            ),


        borderRadius:
            BorderRadius.circular(10),

      ),



      child:

          expanded
              ? buildExpanded()
              : buildCollapsed(),

    );


  }




  Widget buildExpanded() {


    return Stack(

      children: [



        Positioned(

          top: 0,

          left: 5,


          child: IconButton(

            onPressed: () {

              setState(() {

                expanded = false;

              });

            },


            icon:
                const Icon(
                  Icons.keyboard_arrow_up,
                  color: Colors.white,
                ),

          ),

        ),




        Positioned(

          top: 5,

          right: 10,


          child:
              TextButton(

                onPressed:
                    widget.onRemove,


                child:
                    const Text(

                      "Remove",

                      style:

                          TextStyle(

                            color: Colors.red,

                          ),

                    ),

              ),

        ),




        Positioned(

          top: 45,

          left: 15,

          right: 15,


          child: Row(

            children: [


              const Text(

                "Size",

                style:
                    TextStyle(
                      color: Colors.white,
                    ),

              ),



              Expanded(

                child: Slider(

                  min: 40,

                  max: 200,


                  value:
                      widget.sizeValue
                          .clamp(40,200),


                  onChanged:
                      widget.onSizeChanged,

                ),

              ),


            ],

          ),

        ),





        Positioned(

          top: 85,

          left: 15,

          right: 15,


          child: Row(

            children: [


              const Text(

                "Opacity",

                style:
                    TextStyle(
                      color: Colors.white,
                    ),

              ),



              Expanded(

                child: Slider(

                  min: 0,

                  max: 1,


                  value:
                      widget.opacityValue
                          .clamp(0,1),


                  onChanged:
                      widget.onOpacityChanged,

                ),

              ),


            ],

          ),

        ),





        Positioned(

          top: 125,

          left: 15,

          right: 15,


          child: Row(

            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,


            children: [


              ElevatedButton(

                onPressed:
                    widget.onMapXbox,


                child:
                    const Text(
                      "Map To Xbox",
                    ),

              ),



              Text(

                widget.currentMapping == null

                    ? "None"

                    : widget.currentMapping!,


                style:
                    const TextStyle(
                      color: Colors.greenAccent,
                    ),

              ),


            ],

          ),

        ),



      ],

    );


  }





  Widget buildCollapsed() {


    return IconButton(

      onPressed: () {

        setState(() {

          expanded = true;

        });

      },


      icon:
          const Icon(

            Icons.keyboard_arrow_down,

            color: Colors.white,

          ),

    );


  }


}