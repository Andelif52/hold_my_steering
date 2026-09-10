import 'package:shared_preferences/shared_preferences.dart';

class ControllerSettings {
  // Steering Sensitivity

  static int steeringSensitivity = 100;

  // Swipe Sensitivity

  static double swipeSensitivity = 50;

  // Steering Calibration

  static double steeringOffset = 0;

  static bool isCalibrated = false;

  // Analog Stick Settings

  static double analogDeadZone = 10;

  static double analogSensitivity = 100;

  static double getAnalogDeadZone() {
    return analogDeadZone;
  }

  static double getAnalogSensitivity() {
    return analogSensitivity;
  }

  static Future<void> setAnalogDeadZone(double value) async {
    analogDeadZone = value;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setDouble("analogDeadZone", value);
  }

  static Future<void> setAnalogSensitivity(double value) async {
    analogSensitivity = value;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setDouble("analogSensitivity", value);
  }

  // Steering Sensitivity

  static int getSteeringSensitivity() {
    return steeringSensitivity;
  }

  static Future<void> setSteeringSensitivity(int value) async {
    steeringSensitivity = value;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt("steeringSensitivity", value);
  }

  // Swipe Sensitivity

  static double getSwipeSensitivity() {
    return swipeSensitivity;
  }

  static Future<void> setSwipeSensitivity(double value) async {
    swipeSensitivity = value;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setDouble("swipeSensitivity", value);
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

    await prefs.setDouble("steeringCalibration", value);

    await prefs.setBool("isCalibrated", true);
  }

  // Load ALL settings when the app starts.

  static Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    steeringSensitivity = prefs.getInt("steeringSensitivity") ?? 100;

    swipeSensitivity = prefs.getDouble("swipeSensitivity") ?? 50;

    steeringOffset = prefs.getDouble("steeringCalibration") ?? 0.0;

    isCalibrated = prefs.getBool("isCalibrated") ?? false;

    analogDeadZone = prefs.getDouble("analogDeadZone") ?? 10;

    analogSensitivity = prefs.getDouble("analogSensitivity") ?? 100;
  }

  static Future<void> resetCalibration() async {
    steeringOffset = 0.0;
    isCalibrated = false;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setDouble("steeringCalibration", 0.0);

    await prefs.setBool("isCalibrated", false);
  }
}
