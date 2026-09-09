import 'package:flutter/material.dart';

import '../models/controller_layout.dart';
import '../services/layout_storage.dart';



class SavedLayoutsPage extends StatefulWidget {


  const SavedLayoutsPage({
    super.key,
  });



  @override
  State<SavedLayoutsPage> createState() =>
      _SavedLayoutsPageState();

}







class _SavedLayoutsPageState
    extends State<SavedLayoutsPage> {


  List<String> layouts = [];


  bool loading = true;






  @override
  void initState() {

    super.initState();

    loadLayouts();

  }








  Future<void> loadLayouts() async {


    final savedLayouts =
        await LayoutStorage.getSavedLayouts();



    setState(() {


      layouts = savedLayouts;

      loading = false;


    });


  }









  Future<void> openLayout(String name) async {


    final ControllerLayout? layout =
        await LayoutStorage.loadLayout(name);



    if(layout == null) {

      return;

    }



    if(!mounted) {

      return;

    }



    Navigator.pop(

      context,

      layout,

    );


  }









  @override
  Widget build(BuildContext context) {


    return Scaffold(


      backgroundColor: Colors.black,



      appBar: AppBar(


        title: const Text(

          "Edit Existing Configuration",

        ),



        backgroundColor: Colors.black,

        foregroundColor: Colors.white,

        elevation: 0,


      ),






      body: loading


          ? const Center(


              child: CircularProgressIndicator(),


            )



          : layouts.isEmpty


              ? const Center(


                  child: Text(


                    "No saved layouts found",



                    style: TextStyle(


                      color: Colors.white,


                      fontSize: 20,


                    ),



                  ),



                )



              : ListView.builder(



                  padding:

                      const EdgeInsets.all(20),



                  itemCount:

                      layouts.length,



                  itemBuilder:

                      (context,index) {



                    final name =
                        layouts[index];



                    return Card(


                      color:

                          Colors.white10,



                      margin:

                          const EdgeInsets.only(

                            bottom: 15,

                          ),




                      child: ListTile(



                        title: Text(


                          name,



                          style:

                              const TextStyle(


                                color: Colors.white,


                                fontSize: 20,


                              ),



                        ),





                        trailing:

                            const Icon(


                              Icons.edit,


                              color: Colors.white,


                            ),






                        onTap: () {


                          openLayout(name);


                        },



                      ),



                    );



                  },



                ),



    );


  }



}