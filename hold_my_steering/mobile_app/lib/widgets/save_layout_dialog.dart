import 'package:flutter/material.dart';


class SaveLayoutDialog extends StatefulWidget {


  const SaveLayoutDialog({

    super.key,

  });



  @override
  State<SaveLayoutDialog> createState() =>
      _SaveLayoutDialogState();

}







class _SaveLayoutDialogState
    extends State<SaveLayoutDialog> {


  final TextEditingController controller =
      TextEditingController();





  @override
  void dispose() {

    controller.dispose();

    super.dispose();

  }







  @override
  Widget build(BuildContext context) {


    return AlertDialog(


      backgroundColor: Colors.black87,



      title: const Text(


        "Save Configuration",



        style: TextStyle(

          color: Colors.white,

        ),


      ),






      content: TextField(


        controller: controller,



        style: const TextStyle(

          color: Colors.white,

        ),



        decoration: const InputDecoration(


          hintText: "Enter layout name",



          hintStyle: TextStyle(

            color: Colors.white54,

          ),



          enabledBorder: OutlineInputBorder(


            borderSide: BorderSide(

              color: Colors.white54,

            ),


          ),



          focusedBorder: OutlineInputBorder(


            borderSide: BorderSide(

              color: Colors.white,

            ),


          ),



        ),



      ),






      actions: [



        TextButton(


          onPressed: () {


            Navigator.pop(context);


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


            final name =
                controller.text.trim();



            if(name.isEmpty) {

              return;

            }



            Navigator.pop(

              context,

              name,

            );


          },



          child: const Text(

            "Save",

          ),



        ),



      ],



    );


  }


}