import '../models/controller_layout.dart';


class DefaultLayoutGenerator {


  static ControllerLayout create(
      double width,
      double height,
      ) {


    final double buttonSize = height * 0.16;

    final double stickSize = height * 0.25;

    final double shoulderWidth = width * 0.08;

    final double dpadSize = height * 0.25;

    final double smallButtonSize = height * 0.08;



    final double sideMargin = width * 0.04;

    final double topMargin = height * 0.05;




    return ControllerLayout(

      name: "New Configuration",



      buttons: [





        // LEFT BUMPER

        ControllerButton(

          type: "LB",

          x: sideMargin,

          y: topMargin,

          size: shoulderWidth,

          opacity: 1,

          visible: true,

        ),






        // LEFT TRIGGER

        ControllerButton(

          type: "LT",

          x: sideMargin + shoulderWidth + 10,

          y: topMargin,

          size: shoulderWidth,

          opacity: 1,

          visible: true,

        ),






        // RIGHT TRIGGER

        ControllerButton(

          type: "RT",

          x: width - sideMargin - shoulderWidth * 2 - 10,

          y: topMargin,

          size: shoulderWidth,

          opacity: 1,

          visible: true,

        ),






        // RIGHT BUMPER

        ControllerButton(

          type: "RB",

          x: width - sideMargin - shoulderWidth,

          y: topMargin,

          size: shoulderWidth,

          opacity: 1,

          visible: true,

        ),







        // D PAD

        ControllerButton(

          type: "DPAD",

          x: width * 0.18,

          y: height * 0.42,

          size: dpadSize,

          opacity: 1,

          visible: true,

        ),







        // LEFT STICK

        ControllerButton(

          type: "LEFT_STICK",

          x: width * 0.10,

          y: height * 0.65,

          size: stickSize,

          opacity: 1,

          visible: true,

        ),








        // RIGHT STICK

        ControllerButton(

          type: "RIGHT_STICK",

          x: width * 0.72,

          y: height * 0.65,

          size: stickSize,

          opacity: 1,

          visible: true,

        ),







        // Y

        ControllerButton(

          type: "Y",

          x: width * 0.82,

          y: height * 0.25,

          size: buttonSize,

          opacity: 1,

          visible: true,

        ),






        // X

        ControllerButton(

          type: "X",

          x: width * 0.75,

          y: height * 0.42,

          size: buttonSize,

          opacity: 1,

          visible: true,

        ),






        // B

        ControllerButton(

          type: "B",

          x: width * 0.89,

          y: height * 0.42,

          size: buttonSize,

          opacity: 1,

          visible: true,

        ),







        // A

        ControllerButton(

          type: "A",

          x: width * 0.82,

          y: height * 0.58,

          size: buttonSize,

          opacity: 1,

          visible: true,

        ),







        // VIEW

        ControllerButton(

          type: "VIEW",

          x: width * 0.45,

          y: height * 0.82,

          size: smallButtonSize,

          opacity: 1,

          visible: true,

        ),






        // MENU

        ControllerButton(

          type: "MENU",

          x: width * 0.55,

          y: height * 0.82,

          size: smallButtonSize,

          opacity: 1,

          visible: true,

        ),



      ],

    );

  }

}