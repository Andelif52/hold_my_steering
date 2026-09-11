class ControllerLayout {
  String name;
  List<ControllerButton> buttons;

  bool rightStickFullScreen;

  ControllerLayout({
    required this.name,
    required this.buttons,
    this.rightStickFullScreen = false,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "buttons": buttons.map((button) => button.toJson()).toList(),
      "rightStickFullScreen": rightStickFullScreen,
    };
  }

  factory ControllerLayout.fromJson(Map<String, dynamic> json) {
    return ControllerLayout(
      name: json["name"],

      buttons: (json["buttons"] as List)
          .map((button) => ControllerButton.fromJson(button))
          .toList(),

      rightStickFullScreen: json["rightStickFullScreen"] ?? false,
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

  bool fullScreen;

  ControllerButton({
    required this.type,

    required this.x,

    required this.y,

    required this.size,

    required this.opacity,

    required this.visible,

    this.fullScreen = false,
  });

  Map<String, dynamic> toJson() {
    return {
      "type": type,

      "x": x,

      "y": y,

      "size": size,

      "opacity": opacity,

      "visible": visible,

      "fullScreen": fullScreen,
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

      fullScreen: json["fullScreen"] ?? false,
    );
  }
}
