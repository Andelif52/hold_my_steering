import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:async';
import 'dart:ui';
import 'package:sensors_plus/sensors_plus.dart';
import '../settings/controller_settings.dart';

class ControllerScreen extends StatefulWidget {
  final Socket socket;

  const ControllerScreen({
    super.key,
    required this.socket,
  });

  @override
  State<ControllerScreen> createState() => _ControllerScreenState();
}

class _ControllerScreenState extends State<ControllerScreen> {

  double brakeStartY = 0;
  double throttleStartY = 0;

  double brakePercentage = 0;
  double throttlePercentage = 0;

  double get steeringSensitivity =>
      ControllerSettings.steeringSensitivity / 100;


  late StreamSubscription<AccelerometerEvent>
      accelerometerSubscription;


  double getMaxSwipeDistance() {

    double sensitivity =
        ControllerSettings.getSwipeSensitivity();

    double normalizedValue =
        (sensitivity - 25) / 75;

    return lerpDouble(
      400,
      100,
      normalizedValue,
    )!.toDouble();
  }


  int calculatePercentage(
      double startY,
      double currentY,
      ) {

    double distance = startY - currentY;

    double percentage =
        (distance / getMaxSwipeDistance()) * 100;

    percentage = percentage.clamp(0, 100);

    return percentage.toInt();
  }


  int calculateSteering(double yValue) {

    const double maximumSensorValue = 10;
    const double maximumSteeringAngle = 95.0;


    print(yValue);


    double steeringAngle =
        (yValue / maximumSensorValue) *
            maximumSteeringAngle;


    steeringAngle *= steeringSensitivity;


    steeringAngle =
        steeringAngle.clamp(-90.0, 90.0);


    return steeringAngle.round();
  }


  @override
  void initState() {

    super.initState();


    print("ControllerScreen initState called");


    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);


    accelerometerSubscription =
        accelerometerEventStream().listen(
              (event) {

            double yValue = event.y;


            if (ControllerSettings.getCalibrationStatus()) {

              yValue =
                  yValue -
                      ControllerSettings
                          .getSteeringOffset();
            }


            int steering =
            calculateSteering(yValue);


            print("STEER: $steering");


            widget.socket.write(
                "STEER:$steering\n");
          },
        );
  }



  @override
  void dispose() {

    accelerometerSubscription.cancel();


    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);


    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.black,


      body: SafeArea(

        child: Stack(

          children: [

            Row(

              children: [


                // LEFT HALF = BRAKE

                Expanded(

                  child: GestureDetector(

                    onVerticalDragStart: (details) {

                      brakeStartY =
                          details.localPosition.dy;
                    },


                    onVerticalDragUpdate: (details) {


                      int percentage =
                      calculatePercentage(
                        brakeStartY,
                        details.localPosition.dy,
                      );


                      setState(() {

                        brakePercentage =
                            percentage.toDouble();

                      });


                      widget.socket.write(
                          "BRAKE:$percentage\n");

                    },


                    onVerticalDragEnd: (_) {


                      setState(() {

                        brakePercentage = 0;

                      });


                      widget.socket.write(
                          "BRAKE:0\n");

                    },


                    child: Stack(

                      children: [


                        Container(
                            color: Colors.black),



                        Align(

                          alignment:
                          Alignment.bottomCenter,


                          child: AnimatedContainer(

                            duration:
                            const Duration(
                              milliseconds: 100,
                            ),


                            width:
                            double.infinity,


                            height:
                            MediaQuery.of(context)
                                .size
                                .height *
                                (brakePercentage / 100),


                            color:
                            Colors.red
                                .withOpacity(0.7),

                          ),

                        ),

                      ],

                    ),

                  ),

                ),





                // RIGHT HALF = THROTTLE


                Expanded(

                  child: GestureDetector(

                    onVerticalDragStart: (details) {

                      throttleStartY =
                          details.localPosition.dy;

                    },


                    onVerticalDragUpdate: (details) {


                      int percentage =
                      calculatePercentage(
                        throttleStartY,
                        details.localPosition.dy,
                      );


                      setState(() {

                        throttlePercentage =
                            percentage.toDouble();

                      });


                      widget.socket.write(
                          "THROTTLE:$percentage\n");

                    },


                    onVerticalDragEnd: (_) {


                      setState(() {

                        throttlePercentage = 0;

                      });


                      widget.socket.write(
                          "THROTTLE:0\n");

                    },



                    child: Stack(

                      children: [


                        Container(
                            color: Colors.black),



                        Align(

                          alignment:
                          Alignment.bottomCenter,


                          child: AnimatedContainer(

                            duration:
                            const Duration(
                              milliseconds: 100,
                            ),


                            width:
                            double.infinity,


                            height:
                            MediaQuery.of(context)
                                .size
                                .height *
                                (throttlePercentage / 100),


                            color:
                            Colors.green
                                .withOpacity(0.7),

                          ),

                        ),

                      ],

                    ),

                  ),

                ),


              ],

            ),





            // BACK BUTTON

            Positioned(

              top: 5,

              right: 5,


              child: IconButton(

                icon: const Icon(

                  Icons.arrow_back,

                  color: Colors.white,

                  size: 28,

                ),


                onPressed: () {

                  Navigator.pop(context);

                },

              ),

            ),


          ],

        ),

      ),

    );

  }

}