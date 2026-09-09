import 'package:flutter/material.dart';



class DPad extends StatelessWidget {


  final double size;

  final double opacity;

  final bool selected;



  const DPad({

    super.key,

    this.size = 120,

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



          color: Colors.black87,



          borderRadius:
              BorderRadius.circular(20),



          border: Border.all(



            color: selected
                ? Colors.yellow
                : Colors.white,



            width: selected
                ? 5
                : 3,


          ),




          boxShadow: [



            BoxShadow(


              color: selected

                  ? Colors.yellow.withOpacity(0.7)

                  : Colors.transparent,



              blurRadius: 15,


              spreadRadius: 3,


            ),


          ],


        ),





        child: Stack(



          alignment: Alignment.center,



          children: [




            // UP

            Positioned(

              top: size * 0.05,


              child: Icon(

                Icons.keyboard_arrow_up,


                color: Colors.white,


                size: size * 0.28,


              ),

            ),






            // DOWN

            Positioned(

              bottom: size * 0.05,


              child: Icon(

                Icons.keyboard_arrow_down,


                color: Colors.white,


                size: size * 0.28,


              ),

            ),






            // LEFT

            Positioned(

              left: size * 0.05,


              child: Icon(

                Icons.keyboard_arrow_left,


                color: Colors.white,


                size: size * 0.28,


              ),

            ),






            // RIGHT

            Positioned(

              right: size * 0.05,


              child: Icon(

                Icons.keyboard_arrow_right,


                color: Colors.white,


                size: size * 0.28,


              ),

            ),






            // CENTER

            Container(


              width: size * 0.35,


              height: size * 0.35,



              decoration: BoxDecoration(


                color: Colors.black,


                shape: BoxShape.circle,



                border: Border.all(


                  color: Colors.white54,


                  width: 2,


                ),


              ),


            ),



          ],



        ),



      ),



    );


  }


}