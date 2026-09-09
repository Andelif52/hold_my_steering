import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../models/controller_layout.dart';



class LayoutStorage {



  static Future<Directory> _getDirectory() async {

    final directory = await getApplicationDocumentsDirectory();

    final layoutDirectory = Directory(
      "${directory.path}/controller_layouts",
    );


    if (!await layoutDirectory.exists()) {

      await layoutDirectory.create();

    }


    return layoutDirectory;

  }





  static Future<void> saveLayout(
      ControllerLayout layout
      ) async {


    final directory = await _getDirectory();


    final file = File(
      "${directory.path}/${layout.name}.json",
    );


    await file.writeAsString(
      jsonEncode(layout.toJson()),
    );


  }






  static Future<List<String>> getSavedLayouts() async {


    final directory = await _getDirectory();


    final files = directory.listSync();


    return files
        .whereType<File>()
        .map(
          (file) => file.path
              .split("/")
              .last
              .replaceAll(".json", ""),
        )
        .toList();


  }






  static Future<ControllerLayout?> loadLayout(
      String name
      ) async {


    final directory = await _getDirectory();


    final file = File(
      "${directory.path}/$name.json",
    );


    if (!await file.exists()) {

      return null;

    }


    final data = await file.readAsString();


    return ControllerLayout.fromJson(
      jsonDecode(data),
    );


  }







  static Future<void> deleteLayout(
      String name
      ) async {


    final directory = await _getDirectory();


    final file = File(
      "${directory.path}/$name.json",
    );


    if(await file.exists()) {

      await file.delete();

    }


  }


}