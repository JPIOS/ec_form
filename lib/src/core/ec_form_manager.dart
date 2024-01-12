import 'package:ec_form/src/core/ec_form_config.dart';
import 'package:flutter/cupertino.dart' show Color;

class ECFormManager {
  /// app启动的时候需要配置
  /// horizontalSpace 水平边距
  /// selectColor 选中的颜色
  static setup({required double horizontalSpace, required Color selectColor}) {
    ECCormConfig.setup(
        horizontalSpace: horizontalSpace, selectColor: selectColor);
  }
}
