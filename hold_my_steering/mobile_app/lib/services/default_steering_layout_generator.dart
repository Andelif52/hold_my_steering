import '../models/steering_layout.dart';



class DefaultSteeringLayoutGenerator {


  static SteeringLayout create(
      double width,
      double height) {


    return SteeringLayout(

      name: "Default Steering",


      buttons: [],


      throttleMapping: "RT",

      brakeMapping: "LT",

      steeringStick: "LEFT_STICK",

    );

  }


}