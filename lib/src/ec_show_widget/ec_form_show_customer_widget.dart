import 'package:ec_adapter/ec_adapter.dart';
import 'package:flutter/material.dart';

/// 自定义
class ECFormShowCustomerWidget extends StatelessWidget
    with ListViewCellType<ECFormShowCustomerWidgetVM> {
  @override
  Widget build(BuildContext context) {
    return item.content;
  }
}

class ECFormShowCustomerWidgetVM with ListViewItemType {
  final Widget content;
  ECFormShowCustomerWidgetVM(this.content);

  @override
  ListViewCellType<ListViewItemType> cellBuilder() {
    return ECFormShowCustomerWidget();
  }
}
