import 'package:flutter/material.dart'
    show Color, FontWeight, Image, EdgeInsets;

mixin ECFormShowItemVM {
  /// 限制长度
  /// 左边和右边平分，中间间距20
  bool limitLength = true;

  /// 标题
  late String title;

  /// title字体
  double titleFont = 16;

  /// title颜色
  Color titleColor = const Color(0xFF1D2129);

  /// 最大高度
  late double maxHeight;

  /// 字体
  FontWeight fontWeight = FontWeight.normal;

  /// 在右边
  /// 子标题
  /// row: 子标题-子图标-右箭头
  String? subTitle;

  /// 子标题的字体
  double subTitleFont = 16;

  /// 子标题的颜色
  Color subTitleColor = const Color(0xFF4E5969);

  /// 右边的icon
  Image? subIcon;

  /// 是否显示右边的箭头
  bool showArrowRight = false;

  /// 底部设置
  /// 一般外边框整体设计会是32
  /// 因此内部设置默认margin=0
  bool isBLine = true;
  double lineHorMargin = 0;

  /// 路由名字，用于AOP设计跳转
  String? routerName;

  //从后台取数据的key
  String? dataKey;

  /// 是否有自标题
  bool get hasSubtitle => subTitle != null && subTitle!.isNotEmpty;

  /// 边距设置
  EdgeInsets? padding;
}
