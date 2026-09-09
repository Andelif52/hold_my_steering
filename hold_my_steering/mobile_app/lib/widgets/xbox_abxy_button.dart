import 'package:flutter/material.dart';


class XboxABXYButton extends StatelessWidget {


  final String label;

  final double size;

  final double opacity;

  final bool selected;



  const XboxABXYButton({

    super.key,

    required this.label,

    this.size = 80,

    this.opacity = 1.0,

    this.selected = false,

  });






  Color getButtonColor() {


    switch(label) {


      case "A":

        return Colors.green;


      case "B":

        return Colors.red;


      case "X":

        return Colors.blue;


      case "Y":

        return Colors.yellow;


      default:

        return Colors.white;

    }


  }








  @override
  Widget build(BuildContext context) {


    Color buttonColor =
        getButtonColor();




    return Opacity(


      opacity: opacity,



      child: Container(


        width: size,

        height: size,



        decoration: BoxDecoration(



          shape:
              BoxShape.circle,



          color:
              Colors.black87,



          border: Border.all(


            color: selected
                ? Colors.yellow
                : buttonColor,


            width: selected
                ? 6
                : 4,


          ),



          boxShadow: [


            BoxShadow(


              color:
                  selected
                      ? Colors.yellow
                      .withOpacity(0.8)

                      : buttonColor
                      .withOpacity(0.5),



              blurRadius: 15,


              spreadRadius: 3,


            ),


          ],



        ),




        child: Center(


          child: Text(


            label,



            style: TextStyle(


              color:
                  buttonColor,



              fontSize:
                  size * 0.35,



              fontWeight:
                  FontWeight.bold,



            ),



          ),



        ),



      ),



    );



  }



}