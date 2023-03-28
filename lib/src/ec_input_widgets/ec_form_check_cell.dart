import 'package:ec_adapter/ec_adapter.dart';
import 'package:flutter/material.dart';
import 'package:ec_form/ec_form.dart';
import '../core/ec_color.dart';
import '../core/ec_form_config.dart';
import '../core/kd_check_box_widget.dart';

class ECFormCheckCell extends StatelessWidget
    with ListViewCellType<ECFormCheckCellVM> {
  ECFormCheckCell({super.key});
  List<Widget> get rows {
    List<Widget> list = [];
    if (item.title != null) {
      list.add(Text(
        item.title!,
        style: TextStyle(
          fontSize: 16,
          color: ECColor.title,
        ),
      ));
      list.add(const SizedBox(
        width: 36,
      ));
    }

    list.addAll(item.checks
        .map((e) => StreamBuilder<bool>(
            stream: e.check,
            initialData: e.check.value,
            builder: ((context, snapshot) => ECCheckBox(
                  select: e.check.value,
                  title: e.title,
                  isLast: e.title == item.checks.last.title,
                  checkCall: ((p0) {
                    if (e.checkCall != null) {
                      e.checkCall!(p0);
                    }
                    for (var checkItem in item.checks) {
                      if (checkItem.title == e.title) {
                        checkItem.check.value = true;
                        checkItem.checked = true;
                      } else {
                        checkItem.check.value = false;
                        checkItem.checked = false;
                      }
                    }
                  }),
                ))))
        .toList());
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: item.padding,
      child: Column(
        children: [
          Row(
            children: rows,
          ),
          const SizedBox(
            height: 8,
          ),
          Visibility(
            visible: item.subTitle != null,
            child: Text(
              item.subTitle ?? "",
              style: TextStyle(fontSize: 12, color: ECColor.place),
            ),
          )
        ],
      ),
    );
  }
}

class ECFormCheckCellVM with ListViewItemType, ECFormBaseWidgetVM {
  final String? title;
  final String? subTitle;
  final List<ECCheckCellItem> checks;

  ECFormCheckCellVM({
    required String paramKey,
    EdgeInsets? padding,
    this.title,
    this.subTitle,
    required this.checks,
  }) {
    this.paramKey = paramKey;
    this.padding = padding ??
        EdgeInsets.symmetric(horizontal: ECCormConfig.space, vertical: 20);
  }

  @override
  ListViewCellType<ListViewItemType> cellBuilder() => ECFormCheckCell();

  @override
  bool check() {
    return true;
  }

  @override
  Map<String, dynamic> get itemParam {
    for (var c in checks) {
      if (c.checked && c.value != null) {
        return {paramKey: c.value!};
      }
    }
    return {};
  }
}
