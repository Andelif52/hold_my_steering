import 'package:flutter/material.dart';


class XboxABXYButton extends StatelessWidget {


  final String label;

  final double size;

  final double opacity;

  final bool selected;

  final bool pressed;



  const XboxABXYButton({

    super.key,

    required this.label,

    this.size = 80,

    this.opacity = 1.0,

    this.selected = false,

    this.pressed = false,

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


    double currentSize =
        pressed
            ? size * 0.90
            : size;




    return Opacity(


      opacity: opacity,



      child: AnimatedContainer(


        duration:
            const Duration(milliseconds: 80),



        width: currentSize,

        height: currentSize,



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

                : pressed

                    ? 6

                    : 4,


          ),



          boxShadow: [


            BoxShadow(


              color:

                  pressed

                      ? buttonColor.withOpacity(0.9)

                      : selected

                          ? Colors.yellow.withOpacity(0.8)

                          : buttonColor.withOpacity(0.5),



              blurRadius:

                  pressed

                      ? 20

                      : 15,


              spreadRadius:

                  pressed

                      ? 5

                      : 3,


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
                  currentSize * 0.35,



              fontWeight:
                  FontWeight.bold,



            ),



          ),



        ),



      ),



    );



  }



}