import 'package:ec_adapter/ec_adapter.dart';
import 'package:flutter/cupertino.dart';
import '../core/ec_color.dart';
import '../core/ec_table.dart';

// ignore: must_be_immutable
class ECFormTableCell extends StatelessWidget
    with ListViewCellType<ECFormTableCellVM> {
  ECFormTableCell({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: item.padding ?? const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (item.title != null)
                Text(item.title!,
                    style: TextStyle(fontSize: 14, color: ECColor.title)),
              if (item.subTitle != null)
                Text(item.subTitle!,
                    style: TextStyle(fontSize: 14, color: ECColor.subTitle)),
            ],
          ),
          const SizedBox(height: 8),
          ECTable.div(titles: item.titles, rows: item.rows)
        ],
      ),
    );
  }
}

class ECFormTableCellVM with ListViewItemType {
  /// 入参的key
  final String? paramKey;

  /// 标题
  final String? title;

  /// 子标题
  final String? subTitle;

  /// tab的标题数组
  final List<String> titles;

  /// 头部高度
  final double headerHeight;

  /// tab的rows数组
  final List<ECTableRow> rows;

  /// 边距
  final EdgeInsets? padding;

  ECFormTableCellVM({
    this.title,
    this.subTitle,
    required this.titles,
    this.headerHeight = 46,
    required this.rows,
    this.padding,
    this.paramKey,
  });

  /// 添加 row
  add(ECTableRow row) {
    rows.add(row);
  }

  /// 移除 row
  remove(ECTableRow row) {
    if (rows.contains(row)) {
      rows.remove(row);
    }
  }

  @override
  ListViewCellType<ListViewItemType> cellBuilder() => ECFormTableCell();
}
