import 'dart:io';

import 'package:flutter/material.dart';

import 'controller_screen.dart';
import 'game_controller_screen.dart';



class ModeSelectionPage extends StatelessWidget {


  final Socket socket;



  const ModeSelectionPage({

    super.key,

    required this.socket,

  });





  @override
  Widget build(BuildContext context) {


    return Scaffold(


      backgroundColor: Colors.black,



      appBar: AppBar(


        title: const Text(

          "Select Mode",

        ),



        backgroundColor: Colors.black,

        foregroundColor: Colors.white,

        elevation: 0,


      ),





      body: Center(


        child: Padding(


          padding: const EdgeInsets.all(30),



          child: Column(


            mainAxisAlignment:

                MainAxisAlignment.center,



            children: [





              SizedBox(


                width: double.infinity,


                height: 70,



                child: ElevatedButton.icon(


                  icon: const Icon(

                    Icons.directions_car,

                    size: 30,

                  ),



                  label: const Text(

                    "Steering",

                    style: TextStyle(

                      fontSize: 22,

                    ),

                  ),



                  onPressed: () {



                    Navigator.push(


                      context,


                      MaterialPageRoute(


                        builder: (context) =>

                            ControllerScreen(

                              socket: socket,

                            ),


                      ),


                    );



                  },


                ),


              ),






              const SizedBox(height: 40),






              SizedBox(


                width: double.infinity,


                height: 70,



                child: ElevatedButton.icon(


                  icon: const Icon(

                    Icons.gamepad,

                    size: 30,

                  ),



                  label: const Text(

                    "Controller",

                    style: TextStyle(

                      fontSize: 22,

                    ),

                  ),



                  onPressed: () {



                    Navigator.push(


                      context,


                      MaterialPageRoute(


                        builder: (context) =>

                            GameControllerScreen(

                              socket: socket,

                            ),


                      ),


                    );



                  },


                ),


              ),




            ],


          ),


        ),


      ),


    );


  }


}