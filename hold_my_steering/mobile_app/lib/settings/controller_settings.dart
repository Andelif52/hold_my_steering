import 'package:shared_preferences/shared_preferences.dart';

class ControllerSettings {
  // Steering Sensitivity

  static int steeringSensitivity = 100;

  // Swipe Sensitivity

  static double swipeSensitivity = 50;

  // Steering Calibration

  static double steeringOffset = 0;

  static bool isCalibrated = false;

  // Steering Sensitivity

  static int getSteeringSensitivity() {
    return steeringSensitivity;
  }

  static void setSteeringSensitivity(int value) {
    steeringSensitivity = value;
  }

  // Swipe Sensitivity

  static double getSwipeSensitivity() {
    return swipeSensitivity;
  }

  static void setSwipeSensitivity(double value) {
    swipeSensitivity = value;
  }

  // Steering Calibration

  static double getSteeringOffset() {
    return steeringOffset;
  }

  static bool getCalibrationStatus() {
    return isCalibrated;
  }

  static Future<void> setSteeringOffset(double value) async {
    steeringOffset = value;
    isCalibrated = true;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setDouble(
      "steeringCalibration",
      value,
    );

    await prefs.setBool(
      "isCalibrated",
      true,
    );
  }

  static Future<void> loadCalibration() async {
    final prefs = await SharedPreferences.getInstance();

    steeringOffset =
        prefs.getDouble("steeringCalibration") ?? 0.0;

    isCalibrated =
        prefs.getBool("isCalibrated") ?? false;
  }

  static Future<void> resetCalibration() async {
    steeringOffset = 0.0;
    isCalibrated = false;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setDouble(
      "steeringCalibration",
      0.0,
    );

    await prefs.setBool(
      "isCalibrated",
      false,
    );
  }
}