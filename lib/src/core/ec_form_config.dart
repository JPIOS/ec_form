import 'package:flutter/material.dart' show Color;
import 'ec_color.dart';

class ECCormConfig {
  static String package = "kd_form";

  /// 表单组件与两边space，最终已padding方式呈现
  static double space = 16;

  static setup({required double horizontalSpace, required Color selectColor}) {
    space = horizontalSpace;
    ECColor.main = selectColor;
  }
}
