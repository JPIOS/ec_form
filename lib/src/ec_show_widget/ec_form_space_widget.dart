import 'package:ec_adapter/ec_adapter.dart';
import 'package:flutter/material.dart';

/// 用于控制cell之间的间距
/// 可设置高度和背景颜色
class ECFormSpaceWidget extends StatelessWidget
    with ListViewCellType<ECFormSpaceWidgetVM> {
  ECFormSpaceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: item.height,
      color: item.bgColor,
    );
  }
}

class ECFormSpaceWidgetVM<Input> with ListViewItemType {
  final double height;
  final Color? bgColor;
  ECFormSpaceWidgetVM(this.height, {this.bgColor});

  @override
  ListViewCellType<ListViewItemType> cellBuilder() {
    return ECFormSpaceWidget();
  }
}
