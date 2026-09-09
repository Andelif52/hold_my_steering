import 'package:flutter/material.dart';



class AnalogStick extends StatelessWidget {


  final double size;

  final double opacity;

  final bool selected;




  const AnalogStick({


    super.key,


    this.size = 150,


    this.opacity = 1.0,


    this.selected = false,


  });







  @override
  Widget build(BuildContext context) {



    return Opacity(



      opacity: opacity,



      child: Container(



        width: size,

        height: size,



        decoration: BoxDecoration(



          shape:
              BoxShape.circle,



          color:
              Colors.black45,



          border: Border.all(



            color: selected
                ? Colors.yellow
                : Colors.grey,



            width: selected
                ? 6
                : 4,



          ),



          boxShadow: [


            BoxShadow(


              color: selected
                  ? Colors.yellow
                  .withOpacity(0.7)

                  : Colors.transparent,


              blurRadius: 15,


              spreadRadius: 3,


            )


          ],



        ),





        child: Center(



          child: Container(



            width:
                size * 0.45,



            height:
                size * 0.45,



            decoration: BoxDecoration(



              shape:
                  BoxShape.circle,



              color:
                  Colors.black87,



              border: Border.all(



                color:
                    Colors.white54,



                width: 3,



              ),



            ),



          ),



        ),



      ),



    );



  }


}