import 'common/ec_form_mixin_select_alert.dart';
import 'package:ec_adapter/ec_adapter.dart';
import 'common/ec_form_title_widget.dart';
import 'package:flutter/material.dart';
import '../core/ec_border.dart';
import '../core/ec_color.dart';
import '../../ec_form.dart';

/// 选择器组件
// ignore: must_be_immutable
class ECFormInputSelectWidget extends StatelessWidget
    with
        ListViewCellType<ECFormInputSelectWidgetVM>,
        ECFormBaseWidget,
        ECFormMixinSelectAlert {
  ECFormInputSelectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    if (item.value != null && item.selectList != null) {
      // 找到name
      for (var ty in item.selectList!) {
        if (ty.value == item.value!) {
          item.valueStream.add(ty.name);
          break;
        }
      }
    }

    return Padding(
      padding: item.padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ECBaseFormTitleWidget(
              title: item.title,
              showRedPoint: item.visibilityRedPoint,
              subTitle: item.subTitle),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                  child: errorWidget(
                item,
                builder: (err) => GestureDetector(
                  onTap: () {
                    if (!item.enable) return;
                    _selectListAlert(context);
                  },
                  child: Container(
                    height: 40,
                    decoration: ECBorder(
                        bgColor:
                            item.enable ? Colors.white : ECColor.disInputBg,
                        color: !item.enable
                            ? Colors.white
                            : err
                                ? ECColor.errRed
                                : ECColor.border),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        valueChangeWidget<String>(item,
                            builder: (p0) => p0.isEmpty
                                ? Text("请选择",
                                    style: TextStyle(
                                        color: ECColor.place, fontSize: 16))
                                : Text(p0,
                                    style: TextStyle(color: ECColor.title))),
                        Visibility(
                          visible: item.enable,
                          child: Container(
                              padding: const EdgeInsets.only(left: 30),
                              child: Icon(
                                Icons.chevron_right_outlined,
                                color: ECColor.place,
                                size: 22,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
            ],
          ),
          // 底部错误提示
          bottomErrorWidget(item)
        ],
      ),
    );
  }

  _selectListAlert(BuildContext context) async {
    if (item.selectList != null && item.selectList!.isNotEmpty) {
      _alert(context);
      return;
    }
    contentAlert() => _alert(context);

    /// requestSelectCall
    if (item.requestSelectCall != null) {
      List<ECFormInputSelectItem>? models = await item.requestSelectCall!();
      if (models != null) {
        item.selectList = models;
        contentAlert();
      }
    }
  }

  _alert(BuildContext context) {
    if (item.selectList == null) return;
    selectListAlert(context,
        selectList: item.selectList!,
        selectItem: item.selectItem, selectCall: (p0) {
      item.selectItem = p0;

      item.value = item.selectItem!.value;
      item.valueStream.add(item.selectItem!.name);
      if (item.didSelect != null) {
        item.didSelect!(item.selectItem!);
      }
    });
  }
}

class ECFormInputSelectWidgetVM<Input>
    with ECFormBaseWidgetVM, ListViewItemType {
  List<ECFormInputSelectItem>? selectList;
  final Function(ECFormInputSelectItem)? didSelect;

  final Future<List<ECFormInputSelectItem>?> Function()? requestSelectCall;

  /// 选中信息
  ECFormInputSelectItem? selectItem;

  /// 子标题
  String? subTitle;

  ECFormInputSelectWidgetVM(
      {String? title,
      this.subTitle,
      bool ecRequired = true,
      required String paramKey,
      this.selectList,
      ECFormOutCall<dynamic>? checkCall,
      String? errorString,
      bool enable = true,
      this.didSelect,
      this.selectItem,
      this.requestSelectCall,
      EdgeInsets? padding,
      Object? value,
      bool? showRedPoint}) {
    this.title = title;
    this.ecRequired = ecRequired;
    this.paramKey = paramKey;
    this.checkCall = checkCall;
    this.errorString = errorString;
    this.showRedPoint = showRedPoint;
    this.enable = enable;
    this.value = value;

    this.padding =
        padding ?? EdgeInsets.symmetric(horizontal: ECCormConfig.space);
    if (selectItem != null) {
      valueStream.add(selectItem!.name);
      if (didSelect != null) {
        Future.delayed(Duration.zero).then((value) => didSelect!(selectItem!));
      }
    }
  }

  @override
  ListViewCellType<ListViewItemType> cellBuilder() {
    return ECFormInputSelectWidget();
  }

  @override
  Map<String, dynamic> get itemParam => {paramKey: selectItem?.value ?? ""};

  @override
  bool check() {
    // 只要选择了即可
    if (checkCall == null) {
      if (ecRequired) {
        bool success = selectItem != null;
        errStream.add(!success);
        return success;
      }
      return true;
    }

    bool success = checkCall!(value ?? '');
    errStream.add(!success);
    return success;
  }
}
