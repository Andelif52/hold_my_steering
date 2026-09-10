import 'package:flutter/material.dart';

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

class _AnalogStickState extends State<AnalogStick> {
  double knobX = 0;

  double knobY = 0;

  void updateStick(Offset position) {
    double maxDistance = widget.size * 0.275;

    double center = widget.size / 2;

    double x = position.dx - center;

    double y = position.dy - center;

    double distance = Offset(x, y).distance;

    if (distance > maxDistance) {
      double ratio = maxDistance / distance;

      x *= ratio;

      y *= ratio;
    }

    setState(() {
      knobX = x;

      knobY = y;
    });

    double outputX = (x / maxDistance) * 100;

    double outputY = (y / maxDistance) * 100;

    widget.onMove?.call(outputX.clamp(-100, 100), outputY.clamp(-100, 100));
  }

  void resetStick() {
    setState(() {
      knobX = 0;

      knobY = 0;
    });

    widget.onRelease?.call();
  }

  @override
  Widget build(BuildContext context) {
    final double knobSize = widget.size * 0.45;

    Widget stick = Opacity(
      opacity: widget.opacity,

      child: Container(
        width: widget.size,

        height: widget.size,

        decoration: BoxDecoration(
          shape: BoxShape.circle,

          color: Colors.black45,

          border: Border.all(
            color: widget.selected ? Colors.yellow : Colors.grey,

            width: widget.selected ? 6 : 4,
          ),

          boxShadow: [
            BoxShadow(
              color: widget.selected
                  ? Colors.yellow.withOpacity(0.7)
                  : Colors.transparent,

              blurRadius: 15,

              spreadRadius: 3,
            ),
          ],
        ),

        child: Stack(
          children: [
            Positioned(
              left: (widget.size - knobSize) / 2 + knobX,

              top: (widget.size - knobSize) / 2 + knobY,

              child: Container(
                width: knobSize,

                height: knobSize,

                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  color: Colors.black87,

                  border: Border.all(color: Colors.white54, width: 3),
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
        updateStick(details.localPosition);
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
