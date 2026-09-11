import 'package:flutter/material.dart';

class SwitchButton extends StatelessWidget {
  final double size;
  final double opacity;
  final bool selected;

  const SwitchButton({
    super.key,
    this.size = 60,
    this.opacity = 1.0,
    this.selected = false,
  });


  @override
  Widget build(BuildContext context) {

    return Opacity(
      opacity: opacity,

      child: Container(

        width: size,
        height: size,

        decoration: BoxDecoration(

          shape: BoxShape.circle,

          color: Colors.black87,

          border: Border.all(
            color: selected
                ? Colors.yellow
                : Colors.white,

            width: selected ? 4 : 2,
          ),

          boxShadow: [

            BoxShadow(
              color: selected
                  ? Colors.yellow.withOpacity(0.8)
                  : Colors.transparent,

              blurRadius: 15,

              spreadRadius: 3,
            ),

          ],

        ),


        child: Center(

          child: Icon(

            Icons.swap_horiz,

            color: Colors.white,

            size: size * 0.65,

          ),

        ),

      ),

    );

  }
}