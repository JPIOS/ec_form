import 'package:ec_adapter/ec_adapter.dart';
import 'package:flutter/material.dart';
import '../core/ec_grid_widget.dart';

/// 组头大标题
// ignore: must_be_immutable
class ECFormGridViewWidget extends StatelessWidget
    with ListViewCellType<ECFormGridViewWidgetVM> {
  ECFormGridViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ECGradView(
        crossAxisCount: item.crossAxisCount,
        crossAxisSpacing: item.crossAxisSpacing,
        padding: item.padding,
        items: item.items,
        mainAxisSpacing: item.mainAxisSpacing);
  }
}

class ECFormGridViewWidgetVM<Input> with ListViewItemType {
  final List<ECGridCellItem> items;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final EdgeInsets padding;
  final double mainAxisSpacing;

  ECFormGridViewWidgetVM({
    required this.items,
    this.crossAxisCount = 4,
    this.crossAxisSpacing = 0,
    this.padding = EdgeInsets.zero,
    this.mainAxisSpacing = 16,
  });

  @override
  ListViewCellType<ListViewItemType> cellBuilder() {
    return ECFormGridViewWidget();
  }
}
