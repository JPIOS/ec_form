import 'package:flutter/material.dart';
import 'dart:math';
import 'ec_color.dart';

class ECListSheet extends StatelessWidget {
  // final Widget? bottomWidget;
  final String? cancle;
  final List<String> list;
  final Color textColor;
  final Color selectTextColor;
  final String? selectValue;

  /// 如果有cancle 则-1表示点击取消
  final Function(int) indexSelect;
  final BuildContext context;

  /// list颜色是主题色
  /// 有一个取消按钮
  ECListSheet(
    this.context, {
    super.key,
    required this.list,
    this.cancle = "取消",
    required this.indexSelect,
  })  : textColor = ECColor.main,
        selectTextColor = ECColor.main,
        selectValue = null;

  ECListSheet.select(
    this.context, {
    required this.indexSelect,
    required this.list,
    super.key,
    Color? textColor,
    this.selectValue,
    Color? selectTextColor,
    this.cancle = "取消",
  })  : textColor = textColor ?? ECColor.title,
        selectTextColor = selectTextColor ?? ECColor.main;

  @override
  Widget build(BuildContext context) {
    double height = (list.length + 1) * 60.0 + 20;
    height = min(height, 300);

    return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        ),
        height: height,
        child: ListView.separated(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            itemBuilder: (context, index) => _listWidget(index),
            separatorBuilder: (context, index) => Divider(
                  height: 1,
                  color: ECColor.border,
                ),
            itemCount: list.length + 1));
  }

  Widget _listWidget(int index) {
    double cellHeight = 60;
    bool selected = false;
    if (selectValue != null && index < list.length) {
      selected = list[index] == selectValue;
    }

    if (index == list.length) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          height: cellHeight,
          color: Colors.white,
          child: Center(
            child: Text(cancle!,
                style: const TextStyle(color: Colors.black, fontSize: 16)),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        indexSelect(index);
        Navigator.of(context).pop();
      },
      child: Container(
        height: cellHeight,
        color: Colors.white,
        child: Center(
          child: Text(
            list[index],
            style: TextStyle(
                color: selected ? selectTextColor : textColor, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
