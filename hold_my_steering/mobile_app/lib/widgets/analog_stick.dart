import 'package:flutter/material.dart';
import '../settings/controller_settings.dart';

class AnalogStick extends StatefulWidget {
  final double size;

  final double opacity;

  final bool selected;

  final bool interactive;

  final Function(double x, double y)? onMove;

  final VoidCallback? onRelease;

  const AnalogStick({
    super.key,

    this.size = 150,

    this.opacity = 1.0,

    this.selected = false,

    this.interactive = false,

    this.onMove,

    this.onRelease,
  });

  @override
  State<AnalogStick> createState() => _AnalogStickState();
}

class _AnalogStickState extends State<AnalogStick>
    with SingleTickerProviderStateMixin {

  double knobX = 0;

  double knobY = 0;


  bool active = false;


  // Temporary center created when finger touches
  Offset? touchCenter;


  AnimationController? controller;

  Animation<double>? animationX;

  Animation<double>? animationY;


  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,

      duration: const Duration(milliseconds: 250),
    );
  }



  void startStick(Offset position) {

    controller?.stop();


    double center = widget.size / 2;


    setState(() {

      active = true;


      // Move knob instantly to touch position
      knobX = position.dx - center;

      knobY = position.dy - center;


      // This becomes the new zero point
      touchCenter = position;

    });


    // Initial touch should not send movement
    widget.onMove?.call(0, 0);

  }




  void updateStick(Offset position) {

    if (touchCenter == null) {
      return;
    }


    double maxDistance = widget.size * 0.275;


    double x = position.dx - touchCenter!.dx;

    double y = position.dy - touchCenter!.dy;


    double distance = Offset(x, y).distance;


    if (distance > maxDistance) {

      double ratio = maxDistance / distance;

      x *= ratio;

      y *= ratio;

    }



    setState(() {

      knobX =
          (touchCenter!.dx - widget.size / 2) + x;


      knobY =
          (touchCenter!.dy - widget.size / 2) + y;

    });



    double normalizedX = x / maxDistance;

    double normalizedY = y / maxDistance;



    double magnitude =
        Offset(normalizedX, normalizedY).distance;



    if (magnitude < ControllerSettings.analogDeadZone / 100) {

      normalizedX = 0;

      normalizedY = 0;

    } else {

      double adjustedMagnitude =
          (magnitude -
                  ControllerSettings.analogDeadZone / 100) /
              (1 -
                  ControllerSettings.analogDeadZone / 100);


      adjustedMagnitude =
          adjustedMagnitude.clamp(0, 1);



      double scale =
          adjustedMagnitude / magnitude;


      normalizedX *= scale;

      normalizedY *= scale;

    }



    double sensitivity =
        ControllerSettings.analogSensitivity / 100;



    normalizedX *= sensitivity;

    normalizedY *= sensitivity;



    double outputX =
        normalizedX * 100;


    double outputY =
        normalizedY * 100;



    widget.onMove?.call(
      outputX.clamp(-100, 100),

      outputY.clamp(-100, 100),
    );

  }





  void resetStick() {

    animationX =
        Tween<double>(
          begin: knobX,
          end: 0,
        ).animate(controller!);



    animationY =
        Tween<double>(
          begin: knobY,
          end: 0,
        ).animate(controller!);



    controller?.forward(from: 0);



    controller!.addListener(() {

      setState(() {

        knobX = animationX!.value;

        knobY = animationY!.value;

      });

    });



    controller!.addStatusListener((status) {

      if (status == AnimationStatus.completed) {

        setState(() {

          active = false;

          touchCenter = null;

        });

      }

    });



    widget.onRelease?.call();

  }





  @override
  void dispose() {

    controller?.dispose();

    super.dispose();

  }





  @override
  Widget build(BuildContext context) {

    final double knobSize =
        widget.size * 0.45;



    Widget stick = Opacity(

      opacity: widget.opacity,


      child: Container(

        width: widget.size,

        height: widget.size,


        decoration: BoxDecoration(

          shape: BoxShape.circle,


          color: Colors.black45,


          border: Border.all(

            color:
                widget.selected
                    ? Colors.yellow
                    : Colors.grey,


            width:
                widget.selected
                    ? 6
                    : 4,

          ),


          boxShadow: [

            BoxShadow(

              color:
                  active
                      ? Colors.blue.withOpacity(0.6)
                      : Colors.transparent,


              blurRadius: 20,


              spreadRadius: 5,

            ),

          ],

        ),



        child: Stack(

          children: [

            Positioned(

              left:
                  (widget.size - knobSize) / 2 +
                  knobX,


              top:
                  (widget.size - knobSize) / 2 +
                  knobY,



              child: AnimatedScale(

                scale:
                    active
                        ? 0.92
                        : 1.0,


                duration:
                    const Duration(
                      milliseconds: 80,
                    ),



                child: Container(

                  width: knobSize,

                  height: knobSize,



                  decoration: BoxDecoration(

                    shape: BoxShape.circle,


                    color: Colors.black87,


                    border: Border.all(
                      color: Colors.white54,

                      width: 3,
                    ),

                  ),

                ),

              ),

            ),

          ],

        ),

      ),

    );



    if (!widget.interactive) {

      return stick;

    }



    return GestureDetector(

      onPanStart: (details) {

        startStick(details.localPosition);

      },


      onPanUpdate: (details) {

        updateStick(details.localPosition);

      },


      onPanEnd: (_) {

        resetStick();

      },


      child: stick,

    );

  }

}