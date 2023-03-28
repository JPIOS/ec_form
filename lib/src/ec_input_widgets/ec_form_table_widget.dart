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
              item.title == null
                  ? Container()
                  : Text(
                      item.title!,
                      style: TextStyle(
                        fontSize: 14,
                        color: ECColor.title,
                      ),
                    ),
              item.subTitle == null
                  ? Container()
                  : Text(
                      item.subTitle!,
                      style: TextStyle(fontSize: 14, color: ECColor.subTitle),
                    ),
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
  final String? paramKey;
  final String? title;
  final String? subTitle;
  final List<String> titles;
  final double headerHeight;
  final List<ECTableRow> rows;
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
  add(ECTableRow row) {
    rows.add(row);
  }

  remove(ECTableRow row) {
    if (rows.contains(row)) {
      rows.remove(row);
    }
  }

  @override
  ListViewCellType<ListViewItemType> cellBuilder() => ECFormTableCell();
}
