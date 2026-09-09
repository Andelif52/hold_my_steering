import 'package:flutter/material.dart';

import 'controller_editor_page.dart';



class ControllerLayoutPage extends StatelessWidget {


  const ControllerLayoutPage({super.key});




  @override
  Widget build(BuildContext context) {


    return Scaffold(


      backgroundColor: Colors.black,



      appBar: AppBar(


        title: const Text(
          "Controller Configuration",
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


                height: 65,



                child: ElevatedButton(


                  child: const Text(


                    "Add New Configuration",


                    style: TextStyle(
                      fontSize: 20,
                    ),


                  ),




                  onPressed: () {



                    Navigator.push(


                      context,


                      MaterialPageRoute(


                        builder: (context) =>
                            const ControllerEditorPage(),


                      ),


                    );



                  },


                ),


              ),






              const SizedBox(height: 30),






              SizedBox(


                width: double.infinity,


                height: 65,



                child: ElevatedButton(


                  child: const Text(


                    "Edit Existing Configuration",


                    style: TextStyle(
                      fontSize: 20,
                    ),


                  ),



                  onPressed: () {


                    // Implement later


                  },


                ),


              ),







              const SizedBox(height: 30),






              SizedBox(


                width: double.infinity,


                height: 65,



                child: ElevatedButton(


                  child: const Text(


                    "Remove Existing Configuration",


                    style: TextStyle(
                      fontSize: 20,
                    ),


                  ),



                  onPressed: () {


                    // Implement later


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