import 'package:ec_adapter/ec_adapter.dart';
import 'package:flutter/material.dart';
import '../core/ec_form_config.dart';
import '../core/ec_color.dart';
import '../../ec_form.dart';

/// 组头大标题
// ignore: must_be_immutable
class ECFormSectionTitleWidget extends StatelessWidget
    with ListViewCellType<ECFormSectionTitleWidgetVM> {
  ECFormSectionTitleWidget({super.key, ECFormSectionTitleWidgetVM? item}) {
    if (item != null) this.item = item;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: item.padding,
      height: item.maxHeight,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(item.title,
                style: TextStyle(
                    color: item.titleColor,
                    fontSize: item.titleFont,
                    fontWeight: FontWeight.bold)),
            item.rightWidget ?? Container(),
          ],
        ),
      ),
    );
  }
}

class ECFormSectionTitleWidgetVM<Input>
    with ECFormShowItemVM, ListViewItemType {
  final Widget? rightWidget;
  ECFormSectionTitleWidgetVM({
    required String title,
    this.rightWidget,
    Color? titleColor,
    double? kMaxHeight,
    EdgeInsets? padding,
  }) {
    titleFont = 20;
    this.title = title;
    maxHeight = kMaxHeight ?? 68;
    this.titleColor = titleColor ?? ECColor.title;
    this.padding =
        padding ?? EdgeInsets.symmetric(horizontal: ECCormConfig.space);
  }

  @override
  ListViewCellType<ListViewItemType> cellBuilder() {
    return ECFormSectionTitleWidget();
  }
}
