import 'package:flutter/material.dart';

import '../services/steering_layout_storage.dart';


class SavedSteeringLayoutsPage extends StatefulWidget {

  final bool selectionMode;


  const SavedSteeringLayoutsPage({

    super.key,

    this.selectionMode = false,

  });


  @override
  State<SavedSteeringLayoutsPage> createState() =>
      _SavedSteeringLayoutsPageState();

}



class _SavedSteeringLayoutsPageState
    extends State<SavedSteeringLayoutsPage> {


  List<String> layouts = [];

  String? selectedLayout;



  @override
  void initState() {

    super.initState();

    loadLayouts();

  }



  Future<void> loadLayouts() async {

    layouts =
        await SteeringLayoutStorage.getSavedLayouts();


    selectedLayout =
        await SteeringLayoutStorage.getCurrentLayout();


    setState(() {});

  }





  @override
  Widget build(BuildContext context) {


    return Scaffold(

      backgroundColor: Colors.black,


      appBar: AppBar(

        title: Text(

          widget.selectionMode

              ? "Select Current Configuration"

              : "Select Layout To Edit",

        ),


        backgroundColor: Colors.black,

        foregroundColor: Colors.white,

        elevation: 0,

      ),



      body: ListView.builder(

        itemCount: layouts.length,


        itemBuilder: (context,index) {


          final layout =
              layouts[index];


          final isSelected =
              layout == selectedLayout;



          return Container(

            margin:
                const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),


            decoration: BoxDecoration(

              color: Colors.grey[900],

              borderRadius:
                  BorderRadius.circular(12),

            ),



            child: ListTile(


              title: Text(

                layout,

                style:
                    const TextStyle(
                      color: Colors.white,
                    ),

              ),



              trailing: widget.selectionMode

                  ? Icon(

                      Icons.check_circle,

                      color: isSelected

                          ? Colors.green

                          : Colors.white,

                    )

                  : null,




              onTap: () async {


                if(widget.selectionMode) {


                  await SteeringLayoutStorage
                      .saveCurrentLayout(
                        layout,
                      );



                  setState(() {

                    selectedLayout = layout;

                  });


                }

                else {


                  Navigator.pop(

                    context,

                    layout,

                  );


                }


              },


            ),

          );


        },

      ),

    );


  }


}