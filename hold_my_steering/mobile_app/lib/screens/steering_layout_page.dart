import 'package:flutter/material.dart';

import '../services/steering_layout_storage.dart';

import 'saved_steering_layouts_page.dart';
import 'remove_steering_layouts_page.dart';
import 'steering_editor_page.dart';

class SteeringLayoutPage extends StatelessWidget {
  const SteeringLayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        title: const Text("Steering Configuration"),

        backgroundColor: Colors.black,

        foregroundColor: Colors.white,

        elevation: 0,
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              SizedBox(
                width: double.infinity,

                height: 65,

                child: ElevatedButton(
                  child: const Text(
                    "Current Selected Configuration",

                    style: TextStyle(fontSize: 20),
                  ),

                  onPressed: () async {
                    final layoutName = await Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (context) =>
                            const SavedSteeringLayoutsPage(selectionMode: true),
                      ),
                    );

                    if (layoutName != null) {
                      await SteeringLayoutStorage.saveCurrentLayout(layoutName);
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

                    style: TextStyle(fontSize: 20),
                  ),

                  onPressed: () {
                    Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (context) => const SteeringEditorPage(),
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

                    style: TextStyle(fontSize: 20),
                  ),

                  onPressed: () async {
                    final layoutName = await Navigator.push<String>(
                      context,

                      MaterialPageRoute(
                        builder: (context) => const SavedSteeringLayoutsPage(),
                      ),
                    );

                    if (layoutName != null) {
                      final layout = await SteeringLayoutStorage.loadLayout(
                        layoutName,
                      );

                      if (layout != null) {
                        Navigator.push(
                          context,

                          MaterialPageRoute(
                            builder: (context) =>
                                SteeringEditorPage(existingLayout: layout),
                          ),
                        );
                      }
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

                    style: TextStyle(fontSize: 20),
                  ),

                  onPressed: () {
                    Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (context) => const RemoveSteeringLayoutsPage(),
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
