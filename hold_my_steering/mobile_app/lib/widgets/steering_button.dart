import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SteeringButtonWidget extends StatelessWidget {
  final String type;

  final double size;

  final double opacity;

  final bool selected;

  final bool pressed;

  const SteeringButtonWidget({
    super.key,

    required this.type,

    required this.size,

    required this.opacity,

    this.selected = false,

    this.pressed = false,
  });

  String? getSvgPath() {
    switch (type) {
      case "NITRO":
        return "assets/icons/nitro.svg";

      case "HANDBRAKE":
        return "assets/icons/handbrake.svg";

      case "CLUTCH":
        return "assets/icons/clutch.svg";

      case "HORN":
        return "assets/icons/horn.svg";

      default:
        return null;
    }
  }

  IconData? getIcon() {
    switch (type) {
      case "GEAR_UP":
        return Icons.keyboard_arrow_up;

      case "GEAR_DOWN":
        return Icons.keyboard_arrow_down;

      default:
        return null;
    }
  }

  Widget buildButtonIcon() {
    final svgPath = getSvgPath();

    if (svgPath != null) {
      return SvgPicture.asset(svgPath, width: size * 0.55, height: size * 0.55);
    }

    final icon = getIcon();

    if (icon != null) {
      return Icon(icon, color: Colors.white, size: size * 0.55);
    }

    return const Icon(Icons.circle, color: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 80),

        width: pressed ? size * 0.90 : size,

        height: pressed ? size * 0.90 : size,

        decoration: BoxDecoration(
          shape: BoxShape.circle,

          color: Colors.black87,

          border: Border.all(
            color: selected
                ? Colors.yellow
                : pressed
                ? Colors.greenAccent
                : Colors.white,

            width: selected
                ? 5
                : pressed
                ? 5
                : 2,
          ),

          boxShadow: [
            if (pressed)
              BoxShadow(
                color: Colors.greenAccent.withOpacity(0.8),
                blurRadius: 20,
                spreadRadius: 5,
              ),
          ],
        ),

        child: Center(child: buildButtonIcon()),
      ),
    );
  }
}
