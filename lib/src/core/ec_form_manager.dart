import 'package:ec_form/src/core/ec_form_config.dart';
import 'package:flutter/cupertino.dart' show Color;

class ECFormManager {
  /// 配置表单组件两边的space
  static setup({required double horizontalSpace, required Color selectColor}) {
    ECCormConfig.setup(
        horizontalSpace: horizontalSpace, selectColor: selectColor);
  }
}
