import 'package:ec_adapter/ec_adapter.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ECFormBaseContainerWidget extends StatelessWidget
    with ListViewCellType<ECFormBaseContainerWidgetVM> {
  ECFormBaseContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return item.content;
  }
}

class ECFormBaseContainerWidgetVM with ListViewItemType {
  ECFormBaseContainerWidgetVM({required this.content});
  final Widget content;

  @override
  ListViewCellType<ListViewItemType> cellBuilder() {
    return ECFormBaseContainerWidget();
  }
}
