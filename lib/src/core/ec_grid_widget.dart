import 'package:ec_form/src/core/ec_color.dart';
import 'package:flutter/cupertino.dart';

class ECGridCellItem {
  final String title;
  final Color? titleColor;
  final String subTitle;
  final Color? subTitleColor;
  final String? Function()? valueCall;

  ECGridCellItem(
      {required this.title,
      this.titleColor,
      required this.subTitle,
      this.subTitleColor,
      this.valueCall});
}

/// 用于cell内部嵌套，不可滑动
class ECGradView extends StatelessWidget {
  List<ECGridCellItem> items;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;

  final EdgeInsets padding;
  ECGradView({
    super.key,
    required this.items,
    this.crossAxisCount = 4,
    this.mainAxisSpacing = 16.0,
    this.crossAxisSpacing = 0,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: padding,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      crossAxisCount: crossAxisCount,
      semanticChildCount: items.length,
      crossAxisSpacing: 0,
      mainAxisSpacing: mainAxisSpacing,
      childAspectRatio: 1.3,
      children: _childrenWidget(),
    );
  }

  List<Widget> _childrenWidget() {
    return items
        .map((e) => Container(
              // color: Colors.red,
              child: _cell(e),
            ))
        .toList();
  }

  Column _cell(ECGridCellItem e) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(e.title,
            style: TextStyle(
              fontSize: 14,
              color: e.titleColor,
            )),
        const SizedBox(
          height: 4,
        ),
        Text(
          e.subTitle,
          style:
              TextStyle(color: e.subTitleColor ?? ECColor.place, fontSize: 14),
        ),
      ],
    );
  }
}
