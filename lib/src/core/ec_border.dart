import 'package:flutter/material.dart';

enum ECBorderType {
  top,
  left,
  bottom,
  right;

  BorderSide side(Color color, double size) {
    return BorderSide(
      color: color,
      width: size,
    );
  }
}

class ECBorder extends BoxDecoration {
  ECBorder({
    Color color = const Color(0xFFC9CDD4),
    Color? bgColor = Colors.white,
    double? radiu,
    double? borderWidth,
  }) : super(
            color: bgColor,
            borderRadius: BorderRadius.all(Radius.circular(radiu ?? 8)),
            border: Border.all(width: borderWidth ?? 1, color: color));

  /// 只需要一个边框
  static ShapeDecoration defaultSideBorder(
      {Color? color, List<ECBorderType>? types, double? size, Color? bgColor}) {
    List<ECBorderType>? tps = types ??= [ECBorderType.bottom];
    color ??= const Color(0xFFE5E6EB);
    size ??= 1;
    BorderSide top = BorderSide.none;
    BorderSide bottom = BorderSide.none;
    BorderSide start = BorderSide.none;
    BorderSide end = BorderSide.none;

    for (var type in tps) {
      if (type == ECBorderType.bottom) {
        bottom = type.side(color, size);
      } else if (type == ECBorderType.top) {
        top = type.side(color, size);
      } else if (type == ECBorderType.left) {
        start = type.side(color, size);
      } else if (type == ECBorderType.right) {
        end = type.side(color, size);
      }
    }

    return ShapeDecoration(
      color: bgColor,
      shape: BorderDirectional(
        bottom: bottom,
        top: top,
        start: start,
        end: end,
      ),
    );
  }
}
