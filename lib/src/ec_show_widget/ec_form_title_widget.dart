import 'package:ec_adapter/ec_adapter.dart';
import 'package:flutter/material.dart';
import '../../ec_form.dart';
import '../core/ec_border.dart';
import '../core/ec_color.dart';
import '../core/ec_form_config.dart';

/// 包含以下几种
/// 文字 -右标题-右箭头
/// 文字 -右箭头
/// 文字 -右标题
/// 文字 -右icon
/// 文字 -右icon -右箭头
/// 文字 -右 widget
/// 如果设置了limit=true，则两边宽度会固定，会换行最大2行

// ignore: must_be_immutable
class ECFormTitleWidget extends StatelessWidget
    with ListViewCellType<ECFormTitleWidgetVM> {
  ECFormTitleWidget({super.key, ECFormTitleWidgetVM? item}) {
    if (item != null) {
      this.item = item;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.didClick,
      child: Padding(
        padding: item.padding ?? EdgeInsets.zero,
        child: Container(
          decoration: item.isBLine
              ? ECBorder.defaultSideBorder(types: [ECBorderType.bottom])
              : null,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                      color: item.titleColor,
                      fontSize: item.titleFont,
                      fontWeight: item.fontWeight),
                ),
                SizedBox(
                  width: 15,
                  height: item.maxHeight,
                ),
                // subtitle
                _subtitleWidget,

                _subIcon,
                // arrow
                _space(item.showArrowRight),
                Visibility(
                    visible: item.showArrowRight,
                    child: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 16,
                      color: ECColor.subTitle,
                    )),
              ]),
        ),
      ),
    );
  }

  // icon
  Widget get _subIcon => Row(
        children: [
          _space(item.subIcon != null),
          item.subIcon != null ? item.subIcon! : Container(),
        ],
      );

  Widget get _subtitleWidget => item.hasSubtitle
      ? Flexible(
          fit: FlexFit.tight,
          child: Text(
            item.subTitleCallBack != null
                ? item.subTitleCallBack!()
                : item.subTitle ?? "",
            overflow: item.limitLength ? null : TextOverflow.ellipsis,
            textAlign: TextAlign.end,
            style: TextStyle(
                fontSize: item.subTitleFont, color: item.subTitleColor),
          ),
        )
      : Expanded(
          child: Container(),
        );

  Widget _space(bool visible) {
    return Visibility(
      visible: visible,
      child: const SizedBox(
        width: 4,
      ),
    );
  }
}

class ECFormTitleWidgetVM<Input> with ECFormShowItemVM, ListViewItemType {
  final Function()? didClick;
  final String Function()? subTitleCallBack;

  ECFormTitleWidgetVM(
      {this.didClick,
      required String title,
      bool limitLength = false,
      double? titleFont,
      Color? titleColor,
      FontWeight? fontWeight,
      String? subTitle,
      double? subTitleFont,
      Color? subTitleColor,
      Image? subIcon,
      bool showArrowRight = false,
      bool isBLine = true,
      double? lineHorMargin,
      double? maxHeight,
      String? routerName,
      String? dataKey,
      EdgeInsets? margin,
      this.subTitleCallBack,
      EdgeInsets? padding}) {
    this.title = title;
    this.limitLength = limitLength;
    this.titleFont = titleFont ?? 16;
    this.titleColor = titleColor ?? ECColor.title;
    this.maxHeight = maxHeight ?? 60;
    this.fontWeight = fontWeight ?? FontWeight.normal;

    // sub
    this.subTitle = subTitle;
    this.subTitleFont = subTitleFont ?? 16;
    this.subTitleColor = subTitleColor ?? ECColor.subTitle;

    // sub icon
    this.subIcon = subIcon;
    this.showArrowRight = showArrowRight;

    // bLine
    this.isBLine = isBLine;
    this.lineHorMargin = lineHorMargin ?? 16;
    this.routerName = routerName;
    this.dataKey = dataKey;

    this.padding =
        padding ?? EdgeInsets.symmetric(horizontal: ECCormConfig.space);
  }

  @override
  ListViewCellType<ListViewItemType> cellBuilder() {
    return ECFormTitleWidget();
  }
}
