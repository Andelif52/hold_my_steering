import 'package:flutter/material.dart';



class SteeringLayoutControlPanel extends StatefulWidget {


  final VoidCallback onAddButton;

  final VoidCallback onSaveLayout;



  const SteeringLayoutControlPanel({

    super.key,

    required this.onAddButton,

    required this.onSaveLayout,

  });



  @override
  State<SteeringLayoutControlPanel> createState() =>
      _SteeringLayoutControlPanelState();

}




class _SteeringLayoutControlPanelState
    extends State<SteeringLayoutControlPanel> {


  bool expanded = false;



  @override
  Widget build(BuildContext context) {


    return AnimatedContainer(

      duration:
          const Duration(milliseconds: 250),


      width:
          expanded ? 260 : 60,


      height:
          expanded ? 120 : 50,



      decoration: BoxDecoration(

        color: Colors.black87,


        border:
            Border.all(
              color: Colors.white,
              width: 2,
            ),


        borderRadius:
            BorderRadius.circular(12),

      ),



      child:
          expanded
              ? buildExpanded()
              : buildCollapsed(),

    );


  }



  Widget buildExpanded() {


    return Column(

      mainAxisAlignment:
          MainAxisAlignment.center,


      children: [


        IconButton(

          onPressed: () {

            setState(() {

              expanded = false;

            });

          },


          icon:
              const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
              ),

        ),



        Row(

          mainAxisAlignment:
              MainAxisAlignment.spaceEvenly,


          children: [


            ElevatedButton(

              onPressed:
                  widget.onAddButton,


              child:
                  const Text(
                    "Add Button",
                  ),

            ),



            ElevatedButton(

              onPressed:
                  widget.onSaveLayout,


              child:
                  const Text(
                    "Save",
                  ),

            ),



          ],

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
            Icons.keyboard_arrow_up,
            color: Colors.white,
          ),

    );


  }


}