import 'package:flutter/material.dart';
import 'dart:io';
import 'controller_screen.dart';

class WifiPage extends StatefulWidget {
  const WifiPage({super.key});

  @override
  State<WifiPage> createState() => _WifiPageState();
}

class _WifiPageState extends State<WifiPage> {
  final TextEditingController ipController = TextEditingController();

  String connectionStatus = "Not Connected";

  Socket? socket;

  Future<void> connectToPC() async {
    String ip = ipController.text.trim();

    if (ip.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a PC IP Address.")),
      );
      return;
    }

    try {
      socket = await Socket.connect(
        ip,
        5000,
        timeout: const Duration(seconds: 5),
      );

      setState(() {
        connectionStatus = "Connected to $ip";
      });

      // Send a test message
      socket!.write("Hello from Hold My Steering!\n");

      // Go to controller screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ControllerScreen(
            socket: socket!,
          ),
        ),
      );

      // Listen for messages from PC
      socket!.listen(
        (data) {
          String message = String.fromCharCodes(data);

          print("Received: $message");
        },
        onDone: () {
          setState(() {
            connectionStatus = "Disconnected";
          });
        },
        onError: (error) {
          setState(() {
            connectionStatus = "Connection Error";
          });
        },
      );
    } catch (e) {
      String message;

      if (e is SocketException) {
        message =
            "Unable to connect.\n\n"
            "Please make sure:\n"
            "- The PC Receiver app is running.\n"
            "- Both devices are on the same WiFi network.\n"
            "- The IP address is correct.";
      } else {
        message = "An unexpected error occurred.";
      }

      setState(() {
        connectionStatus = message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("WiFi Connection"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 30),

            const Text(
              "Connect to your PC",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              "Make sure your phone and PC are connected to the same WiFi network.",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),

            const SizedBox(height: 40),

            TextField(
              controller: ipController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "PC IP Address",
                labelStyle: const TextStyle(color: Colors.grey),
                hintText: "e.g. 192.168.0.15",
                hintStyle: const TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              height: 60,
              child: ElevatedButton(
                onPressed: connectToPC,
                child: const Text("Connect", style: TextStyle(fontSize: 18)),
              ),
            ),

            const SizedBox(height: 40),

            Card(
              color: Colors.grey[900],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "Status: $connectionStatus",
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
