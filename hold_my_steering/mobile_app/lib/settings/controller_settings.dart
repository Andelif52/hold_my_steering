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
}