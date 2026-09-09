class ControllerLayout {
  String name;
  List<ControllerButton> buttons;

  ControllerLayout({
    required this.name,
    required this.buttons,
  });


  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "buttons": buttons.map((button) => button.toJson()).toList(),
    };
  }


  factory ControllerLayout.fromJson(Map<String, dynamic> json) {
    return ControllerLayout(
      name: json["name"],

      buttons: (json["buttons"] as List)
          .map(
            (button) => ControllerButton.fromJson(button),
          )
          .toList(),
    );
  }
}



class ControllerButton {

  String type;

  double x;
  double y;

  double size;

  double opacity;

  bool visible;


  ControllerButton({

    required this.type,

    required this.x,

    required this.y,

    required this.size,

    required this.opacity,

    required this.visible,

  });



  Map<String, dynamic> toJson() {

    return {

      "type": type,

      "x": x,

      "y": y,

      "size": size,

      "opacity": opacity,

      "visible": visible,

    };

  }



  factory ControllerButton.fromJson(Map<String, dynamic> json) {

    return ControllerButton(

      type: json["type"],

      x: json["x"],

      y: json["y"],

      size: json["size"],

      opacity: json["opacity"],

      visible: json["visible"],

    );

  }

}