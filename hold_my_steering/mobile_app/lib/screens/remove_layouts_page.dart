import 'package:flutter/material.dart';

import '../services/layout_storage.dart';



class RemoveLayoutsPage extends StatefulWidget {


  const RemoveLayoutsPage({

    super.key,

  });



  @override
  State<RemoveLayoutsPage> createState() =>
      _RemoveLayoutsPageState();

}







class _RemoveLayoutsPageState
    extends State<RemoveLayoutsPage> {


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









  Future<void> confirmDelete(String name) async {


    final shouldDelete =
        await showDialog<bool>(


          context: context,


          builder: (context) {


            return AlertDialog(


              backgroundColor:
                  Colors.black87,



              title: const Text(


                "Delete Configuration?",



                style: TextStyle(

                  color: Colors.white,

                ),


              ),





              content: Text(


                "Are you sure you want to delete \"$name\"?",



                style: const TextStyle(

                  color: Colors.white,

                ),


              ),





              actions: [



                TextButton(


                  onPressed: () {


                    Navigator.pop(

                      context,

                      false,

                    );


                  },



                  child: const Text(


                    "Cancel",



                    style: TextStyle(

                      color: Colors.white,

                    ),


                  ),



                ),






                ElevatedButton(


                  onPressed: () {


                    Navigator.pop(

                      context,

                      true,

                    );


                  },



                  child: const Text(

                    "Delete",

                  ),



                ),



              ],



            );


          },

        );





    if(shouldDelete != true) {

      return;

    }






    await LayoutStorage.deleteLayout(

      name,

    );





    await loadLayouts();



  }









  @override
  Widget build(BuildContext context) {


    return Scaffold(


      backgroundColor: Colors.black,



      appBar: AppBar(


        title: const Text(

          "Remove Existing Configuration",

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


                              Icons.delete,


                              color: Colors.red,


                            ),






                        onTap: () {


                          confirmDelete(name);


                        },



                      ),



                    );



                  },



                ),



    );


  }



}