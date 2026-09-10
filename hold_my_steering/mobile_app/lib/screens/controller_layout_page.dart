import 'package:flutter/material.dart';

import 'controller_editor_page.dart';
import 'saved_layouts_page.dart';
import 'remove_layouts_page.dart';
import '../services/layout_storage.dart';



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





              // CURRENT SELECTED CONFIGURATION


              SizedBox(


                width: double.infinity,


                height: 65,



                child: ElevatedButton(


                  child: const Text(


                    "Current Selected Configuration",


                    style: TextStyle(
                      fontSize: 20,
                    ),


                  ),



                  onPressed: () async {


                    final layoutName =
                        await Navigator.push(


                          context,


                          MaterialPageRoute(


                            builder: (context) =>
                                const SavedLayoutsPage(
                                  selectionMode: true,
                                ),


                          ),


                        );



                    if(layoutName != null) {


                      await LayoutStorage
                          .saveCurrentLayout(
                            layoutName,
                          );

                    }



                  },


                ),


              ),





              const SizedBox(height: 30),





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



                  onPressed: () async {


                    final layout =
                        await Navigator.push(


                          context,


                          MaterialPageRoute(


                            builder: (context) =>
                                const SavedLayoutsPage(),


                          ),


                        );



                    if(layout != null && context.mounted) {


                      Navigator.push(


                        context,


                        MaterialPageRoute(


                          builder: (context) =>

                              ControllerEditorPage(

                                existingLayout: layout,

                              ),


                        ),


                      );


                    }



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


                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (context) =>
                            const RemoveLayoutsPage(),

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