import 'package:flutter/material.dart';

import '../services/steering_layout_storage.dart';



class RemoveSteeringLayoutsPage extends StatefulWidget {

  const RemoveSteeringLayoutsPage({super.key});


  @override
  State<RemoveSteeringLayoutsPage> createState() =>
      _RemoveSteeringLayoutsPageState();

}




class _RemoveSteeringLayoutsPageState
    extends State<RemoveSteeringLayoutsPage> {


  List<String> layouts = [];



  @override
  void initState() {

    super.initState();

    load();

  }



  void load() async {

    layouts =
        await SteeringLayoutStorage
            .getSavedLayouts();


    setState(() {});

  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(

      backgroundColor: Colors.black,


      appBar: AppBar(

        title:
            const Text(
              "Remove Steering Layout",
            ),

        backgroundColor: Colors.black,

        foregroundColor: Colors.white,

      ),



      body: ListView.builder(

        itemCount: layouts.length,


        itemBuilder: (context,index) {


          return ListTile(

            title: Text(

              layouts[index],

              style:
                  const TextStyle(
                    color: Colors.white,
                  ),

            ),



            trailing: IconButton(

              icon:
                  const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),



              onPressed: () async {


                await SteeringLayoutStorage
                    .deleteLayout(
                      layouts[index],
                    );


                load();


              },


            ),


          );


        },


      ),


    );


  }


}