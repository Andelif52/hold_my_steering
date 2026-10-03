class SteeringLayout {
  String name;

  List<SteeringButton> buttons;

  String throttleMapping;
  String brakeMapping;

  String steeringStick;

  SteeringLayout({
    required this.name,
    required this.buttons,
    this.throttleMapping = "RT",
    this.brakeMapping = "LT",
    this.steeringStick = "LEFT_STICK",
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,

      "buttons": buttons.map((button) => button.toJson()).toList(),

      "throttleMapping": throttleMapping,

      "brakeMapping": brakeMapping,

      "steeringStick": steeringStick,
    };
  }

  factory SteeringLayout.fromJson(Map<String, dynamic> json) {
    return SteeringLayout(
      name: json["name"],

      buttons: (json["buttons"] as List)
          .map((button) => SteeringButton.fromJson(button))
          .toList(),

      throttleMapping: json["throttleMapping"] ?? "RT",

      brakeMapping: json["brakeMapping"] ?? "LT",

      steeringStick: json["steeringStick"] ?? "LEFT_STICK",
    );
  }
}

class SteeringButton {
  String type;

  double x;

  double y;

  double size;

  double opacity;

  bool visible;

  String? xboxMapping;

  bool editable;

  SteeringButton({
    required this.type,

    required this.x,

    required this.y,

    required this.size,

    required this.opacity,

    required this.visible,

    this.xboxMapping,

    this.editable = true,
  });

  Map<String, dynamic> toJson() {
    return {
      "type": type,

      "x": x,

      "y": y,

      "size": size,

      "opacity": opacity,

      "visible": visible,

      "xboxMapping": xboxMapping,

      "editable": editable,
    };
  }

  factory SteeringButton.fromJson(Map<String, dynamic> json) {
    return SteeringButton(
      type: json["type"],

      x: (json["x"] ?? 0).toDouble(),

      y: (json["y"] ?? 0).toDouble(),

      size: (json["size"] ?? 80).toDouble(),

      opacity: (json["opacity"] ?? 1).toDouble(),

      visible: json["visible"] ?? true,

      xboxMapping: json["xboxMapping"],

      editable: json["editable"] ?? true,
    );
  }
}
