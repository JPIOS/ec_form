import 'common/ec_form_mixin_select_alert.dart';
import 'package:ec_adapter/ec_adapter.dart';
import 'common/ec_form_title_widget.dart';
import 'package:flutter/material.dart';
import '../core/ec_form_config.dart';
import '../core/ec_text_filed.dart';
import 'package:rxdart/rxdart.dart';
import '../core/ec_border.dart';
import '../core/ec_color.dart';
import '../../ec_form.dart';

/// 单位背景灰色
// ignore: must_be_immutable
class ECFormInputSelectUnitWidget extends StatelessWidget
    with
        ListViewCellType<ECFormInputSelectUnitWidgetVM>,
        ECFormBaseWidget,
        ECFormMixinSelectAlert {
  ECFormInputSelectUnitWidget({super.key, ECFormInputSelectUnitWidgetVM? vm}) {
    if (vm != null) item = vm;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: item.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ECBaseFormTitleWidget(
              title: item.title, showRedPoint: item.visibilityRedPoint),
          SizedBox(height: item.title == null ? 0 : 8),
          Row(
            children: [
              Expanded(
                  child: errorWidget(
                item,
                builder: (err) => Container(
                  clipBehavior: Clip.hardEdge,
                  height: 40,
                  decoration: ECBorder(
                      bgColor: item.enable ? Colors.white : ECColor.disInputBg,
                      color: err ? ECColor.errRed : ECColor.border),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 4),
                      Expanded(
                          child: ECTextFiled.aLineInput(
                              readOnly: !item.enable,
                              keyboardType: item.keyboardType,
                              onChanged: (p0) {
                                item.value = p0;
                                if (item.onChanged != null) {
                                  item.onChanged!(p0);
                                }
                              },
                              controller: item.textController)),
                      GestureDetector(
                        onTap: () {
                          if (item.unitCanSelect) {
                            _selectListAlert(context);
                          }
                        },
                        child: Container(
                          color: ECColor.grayDisable,
                          width: item.kUnitWidth,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              StreamBuilder<ECFormInputSelectItem>(
                                  initialData: item.selectedItem,
                                  stream: item.unitSelectSubject,
                                  builder: ((context, snapshot) => Text(
                                      "${snapshot.requireData.name}${item.unitCanSelect ? " " : ""}"))),
                              item.unitCanSelect
                                  ? Icon(
                                      Icons.arrow_drop_down_outlined,
                                      color: ECColor.place,
                                      size: 16,
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      )
                    ],
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
    _alert(context);
  }

  _alert(BuildContext context) {
    if (item.unitSelectList == null) return;
    selectListAlert(context,
        selectList: item.unitSelectList!,
        selectItem: item.selectedItem, selectCall: (p0) {
      item.selectedItem = p0;
      item.unitSelectSubject.add(p0);
      if (item.didSelectUnit != null) {
        item.didSelectUnit!(item.selectedItem);
      }
    });
  }
}

class ECFormInputSelectUnitWidgetVM<Input>
    with ECFormBaseWidgetVM, ListViewItemType {
  ECFormInputSelectUnitWidgetVM(
      {String? title,
      bool ecRequired = true,
      required String paramKey,
      this.unitParamKey,
      // unit
      this.unitCanSelect = false,
      this.unitSelectList,
      this.didSelectUnit,
      this.unitNameParamKey,
      required this.selectedItem,
      this.onChanged,
      ECFormOutCall<dynamic>? checkCall,
      String? errorString,
      bool enable = true,
      double? unitWidth,
      String? value,
      EdgeInsets? padding,
      int? maxLength,
      double errorHeight = 25,
      this.keyboardType,
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
    unitSelectSubject = BehaviorSubject.seeded(selectedItem);
    kUnitWidth = unitWidth ?? 100;
    kErrorHeight = errorHeight;
    if (value != null) {
      textController.text = value;
    }
    if (didSelectUnit != null) {
      Future.delayed(Duration.zero)
          .then((value) => didSelectUnit!(selectedItem));
      valueStream.add(selectedItem.name);
    }
    unitNameParamKey ??= "${unitParamKey}Name";
  }

  /// 单位数组
  List<ECFormInputSelectItem>? unitSelectList;

  /// 单位选择
  late BehaviorSubject<ECFormInputSelectItem> unitSelectSubject;

  /// 文本输入控制器
  late TextEditingController textController = TextEditingController();

  /// 选择的单位
  final Function(ECFormInputSelectItem)? didSelectUnit;

  /// 单位宽度
  double? kUnitWidth;

  /// 是否能选择单位
  final bool unitCanSelect;

  /// 错误提示高度
  late double kErrorHeight;

  /// 单位参入的 key：针对id
  final String? unitParamKey;

  /// 单位名字入参的key
  String? unitNameParamKey;

  /// 文字改动回调
  final Function(String)? onChanged;

  /// 键盘类型
  final TextInputType? keyboardType;

  /// 选中单位
  ECFormInputSelectItem selectedItem;

  @override
  ListViewCellType<ListViewItemType> cellBuilder() {
    return ECFormInputSelectUnitWidget();
  }

  @override
  bool check() {
    // 只要选择了即可
    if (checkCall == null) {
      if (ecRequired) {
        bool success = value != null;
        errStream.add(!success);
        return success;
      }
      return true;
    }

    bool success = checkCall!(value ?? '');
    errStream.add(!success);
    return success;
  }

  @override
  Map<String, dynamic> get itemParam {
    if (unitCanSelect && unitParamKey != null && unitParamKey!.isNotEmpty) {
      Map<String, dynamic> pm = {
        paramKey: value,
        unitParamKey!: selectedItem.value,
      };
      if (unitNameParamKey != null) {
        pm[unitNameParamKey!] = selectedItem.name;
      }
      return pm;
    }
    return super.itemParam;
  }
}
