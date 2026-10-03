import 'package:flutter/material.dart';


class SaveSteeringLayoutDialog extends StatefulWidget {

  const SaveSteeringLayoutDialog({
    super.key,
  });


  @override
  State<SaveSteeringLayoutDialog> createState() =>
      _SaveSteeringLayoutDialogState();

}



class _SaveSteeringLayoutDialogState
    extends State<SaveSteeringLayoutDialog> {


  final controller =
      TextEditingController();



  @override
  Widget build(BuildContext context) {


    return AlertDialog(

      backgroundColor: Colors.black87,


      title:
          const Text(
            "Save Steering Layout",
            style:
                TextStyle(
                  color: Colors.white,
                ),
          ),



      content:

          TextField(

            controller: controller,


            style:
                const TextStyle(
                  color: Colors.white,
                ),


            decoration:
                const InputDecoration(

                  hintText:
                      "Layout Name",

                ),

          ),



      actions: [


        TextButton(

          onPressed: () {

            Navigator.pop(context);

          },


          child:
              const Text(
                "Cancel",
              ),

        ),



        ElevatedButton(

          onPressed: () {


            Navigator.pop(

              context,

              controller.text.trim(),

            );


          },


          child:
              const Text(
                "Save",
              ),

        ),


      ],


    );


  }


}