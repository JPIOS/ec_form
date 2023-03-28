import 'package:flutter/material.dart';

class ECColor {
  ///  主题色
  static Color main = const Color(0xFF13B580);

  ///  主题色按钮不可点击
  static Color mainDisable = const Color(0xFFA1E1CC);

  /// 主题blue
  static Color mainBlue = const Color(0xFF1990FF);

  /// 错误提示文字
  static Color errRed = const Color(0xFFFF4D4F);

  /// 输入提示颜色
  static Color place = const Color(0xFF86909C);

  /// 文字输入颜色
  static Color input = const Color(0xFF1D2129);

  /// 输入框不可编辑背景颜色
  static Color disInputBg = const Color(0xFFE5E6EB);

  /// table头部背景
  static Color tableBg = const Color(0xFFF0F2F5);

  /// 边框颜色
  static Color border = const Color(0xFFC9CDD4);

  /// 标题颜色
  static Color title = const Color(0xFF1D2129);

  /// 子标题
  static Color subTitle = const Color(0xFF4E5969);

  /// 不可用灰色
  static Color grayDisable = const Color(0xFFC9CDD4);

  /// tag
  static Color mainTagbg = const Color(0xFFF5FFFB);
  static Color blueTagbg = const Color(0xFFF1F8FF);

  static Color kE7F8F2 = const Color(0xFFE7F8F2);

  /// line 颜色
  static Color line = const Color(0xFFDEDEDE);
  static Color yellow = const Color(0xFFFAAD14);

  /// 通过字符串转颜色
  /// from("#1D2129")
  /// from("1D2129")
  static Color hex(String hex) {
    if (hex.contains("#")) {
      hex = hex.replaceAll("#", "");
    }

    assert(hex.length == 6, '颜色值长度不是6');
    hex = '0xff$hex';
    return Color(int.parse(hex));
  }
}
