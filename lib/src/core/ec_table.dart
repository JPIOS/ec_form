import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'ec_text_filed.dart';
import 'ec_color.dart';

class ECTableRow {
  final List<ECTableRowItem> items;
  ECTableRow(this.items);
}

class ECTableRowItem {
  ECTableRowItem({
    this.paramKey,
    this.isInput = false,
    required this.title,
    this.inputUnit,
    this.enable = true,
    this.didSelect,
    this.inputChange,
    this.valueCall,
    this.titleColor,
  }) {
    controller.text = title;
    inputText = title;
  }

  /// 是否是显示模式
  final bool isInput;

  /// 显示标题
  String title;

  /// 标题颜色
  final Color? titleColor;

  /// 单位
  /// isInput默认一般会存在
  final String? inputUnit;

  /// 表单参数key
  final String? paramKey;

  /// 输入的文字
  String? inputText;
  late final TextEditingController controller = TextEditingController();

  /// 如果是disable则会有灰色的背景
  bool enable;

  /// 选择类型：选中了一个 row
  final Function(ECTableRowItem)? didSelect;

  /// Rx<String> selectValue = "请选择".obs;
  BehaviorSubject<String> selectValue = BehaviorSubject.seeded("请选择");

  /// 当输入类型，数据文字变化的回调
  final Function(String)? inputChange;

  /// 输入类型：选择类型谨慎使用
  String Function()? valueCall;
}

class ECTable extends StatelessWidget {
  const ECTable.div({
    super.key,
    required this.titles,
    this.headerHeight = 44,
    required this.rows,
    this.firstRato = 1,
  });

  /// 标题数组
  final List<String> titles;

  /// 表头部高度
  final double headerHeight;

  /// row 数组
  final List<ECTableRow> rows;

  /// 头部宽高比例：控制tab头部
  final double firstRato;
  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: ECColor.disInputBg),
      columnWidths: {0: IntrinsicColumnWidth(flex: firstRato)},
      children: initRows(),
    );
  }

  List<TableRow> initRows() {
    List<TableRow> list = [];
    // header
    list.add(TableRow(children: titles.map((e) => _titleRow(e)).toList()));
    list.addAll(rows.map(
        (e) => TableRow(children: e.items.map((e) => _showRow(e)).toList())));
    return list;
  }

  Widget _titleRow(String title) {
    return Container(
        height: headerHeight,
        color: ECColor.tableBg,
        child: Center(
            child: Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        )));
  }

  Widget _showRow(ECTableRowItem item) {
    // 数据回选
    if (item.valueCall != null) {
      String v = item.valueCall!();
      item.selectValue.value = v;
      item.title = v;
    }

    if (!item.enable) {
      return _disableRow(item);
    }

    if (item.isInput) {
      return _inputRow(item);
    }
    if (item.didSelect != null) {
      return GestureDetector(
        onTap: () {
          item.didSelect!(item);
        },
        child: SizedBox(
            height: 40,
            child: StreamBuilder<String>(
              stream: item.selectValue,
              initialData: item.selectValue.value,
              builder: ((context, snapshot) {
                return Center(
                    child: Text(
                  item.selectValue.value,
                  style: TextStyle(fontSize: 14, color: ECColor.title),
                ));
              }),
            )),
      );
    }

    return SizedBox(
      height: 40,
      child: Center(
          child: Text(
        item.title,
        style: TextStyle(fontSize: 14, color: item.titleColor),
      )),
    );
  }

  Widget _inputRow(ECTableRowItem item) {
    return Container(
      color: Colors.white,
      height: 40,
      child: Row(
        children: [
          Expanded(
              child: ECTextFiled.aLineInput(
                  placeholderStyle:
                      TextStyle(fontSize: 14, color: ECColor.place),
                  height: 40,
                  controller: item.controller,
                  onChanged: ((p0) {
                    item.inputText = p0;
                    item.inputChange?.call(p0);
                  }),
                  style: const TextStyle(fontSize: 14))),
          Text(
            item.inputUnit ?? "",
            style: TextStyle(fontSize: 14, color: ECColor.title),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget _disableRow(ECTableRowItem item) {
    return Container(
        height: 40,
        color: ECColor.tableBg,
        child: Center(
            child: Text(
          item.title,
          style: TextStyle(fontSize: 14, color: ECColor.title),
        )));
  }
}
