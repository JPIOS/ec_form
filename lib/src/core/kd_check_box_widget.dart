import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'ec_color.dart';

// 一排多个check，单选
class ECCheckCellItem {
  ECCheckCellItem(
    this.title, {
    this.checked = true,
    this.checkCall,
    this.value,
  }) {
    check.value = checked;
  }

  /// 标题
  final String title;

  /// 是否勾选
  bool checked;

  /// 错误stream
  BehaviorSubject<bool> check = BehaviorSubject.seeded(false);

  /// 勾选动作的回调
  final Function(bool)? checkCall;

  /// 拓展值
  final String? value;
}

class ECCheckBoxList extends StatelessWidget {
  final List<ECCheckCellItem> checks;
  final bool spaceBetween;

  const ECCheckBoxList(this.checks, {super.key, this.spaceBetween = true});

  List<Widget> get rows {
    List<Widget> list = [];

    list.addAll(checks
        .map((e) => StreamBuilder<bool>(
            stream: e.check,
            initialData: e.check.value,
            builder: ((context, snapshot) => ECCheckBox(
                  select: e.check.value,
                  title: e.title,
                  isLast: spaceBetween ? true : e.title == checks.last.title,
                  checkCall: ((p0) {
                    e.checkCall?.call(p0);

                    for (var checkItem in checks) {
                      final isCheck = checkItem.title == e.title;
                      checkItem.check.value = isCheck;
                      checkItem.checked = isCheck;
                    }
                  }),
                ))))
        .toList());
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: spaceBetween
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.start,
      children: rows,
    );
  }
}

// ignore: must_be_immutable
class ECCheckBox extends StatelessWidget {
  bool select;
  String? title;
  Function(bool)? checkCall;
  final bool isLast;
  ECCheckBox(
      {super.key,
      required this.select,
      this.title,
      this.checkCall,
      this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        select = !select;
        if (checkCall != null) {
          checkCall!(select);
        }
      },
      child: Padding(
        padding: EdgeInsets.only(right: isLast ? 0 : 36),
        child: Row(
          children: [
            Icon(
              select ? Icons.check : Icons.check_box_outline_blank,
              size: 16,
              color: select ? ECColor.main : ECColor.place,
            ),
            SizedBox(
              width: title == null ? 0 : 3,
            ),
            Visibility(
                visible: title != null,
                child: Text(
                  title ?? "",
                  style: TextStyle(fontSize: 16, color: ECColor.title),
                ))
          ],
        ),
      ),
    );
  }
}
