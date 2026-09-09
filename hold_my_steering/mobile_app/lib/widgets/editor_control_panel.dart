import 'package:flutter/material.dart';


class EditorControlPanel extends StatefulWidget {


  final double sizeValue;

  final double opacityValue;


  final Function(double) onSizeChanged;

  final Function(double) onOpacityChanged;


  final VoidCallback onRemove;



  const EditorControlPanel({

    super.key,

    required this.sizeValue,

    required this.opacityValue,

    required this.onSizeChanged,

    required this.onOpacityChanged,

    required this.onRemove,

  });



  @override
  State<EditorControlPanel> createState() =>
      _EditorControlPanelState();

}






class _EditorControlPanelState
    extends State<EditorControlPanel> {


  bool expanded = true;



  @override
  Widget build(BuildContext context) {


    return AnimatedContainer(


      duration: const Duration(milliseconds: 250),



      width: expanded ? 300 : 60,



      height: expanded ? 130 : 50,



      decoration: BoxDecoration(


        color: Colors.black87,


        border: Border.all(

          color: Colors.white,

          width: 2,

        ),



        borderRadius:

            BorderRadius.circular(10),


      ),



      child: expanded

          ? buildExpanded()

          : buildCollapsed(),


    );


  }









  Widget buildExpanded() {


    return Stack(


      children: [




        Positioned(


          top: 5,

          left: 10,


          child: TextButton(


            onPressed: () {


              setState(() {


                expanded = false;


              });


            },


            child: const Icon(


              Icons.keyboard_arrow_up,


              color: Colors.white,


            ),


          ),


        ),







        Positioned(


          top: 10,

          right: 10,


          child: TextButton(


            onPressed: widget.onRemove,


            child: const Text(


              "Remove",


              style: TextStyle(

                color: Colors.red,

                fontSize: 14,

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

                style: TextStyle(

                  color: Colors.white,

                ),


              ),



              Expanded(


                child: Slider(


                  min: 40,

                  max: 200,


                  value: widget.sizeValue.clamp(

                    40,

                    200,

                  ),



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

                style: TextStyle(

                  color: Colors.white,

                ),


              ),




              Expanded(


                child: Slider(


                  min: 0.0,

                  max: 1.0,


                  value: widget.opacityValue.clamp(

                    0.0,

                    1.0,

                  ),



                  onChanged:

                      widget.onOpacityChanged,


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



      icon: const Icon(


        Icons.keyboard_arrow_down,


        color: Colors.white,


      ),


    );


  }



}