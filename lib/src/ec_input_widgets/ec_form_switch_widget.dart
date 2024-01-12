import 'package:flutter/cupertino.dart' show CupertinoSwitch;
import '../core/ec_form_base_widget_vm.dart';
import 'package:ec_adapter/ec_adapter.dart';
import '../core/ec_form_base_widget.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../core/ec_color.dart';

/// switch开关组件
// ignore: must_be_immutable
class ECFormSwitchWidget extends StatelessWidget
    with ListViewCellType<ECFormSwitchWidgetVM>, ECFormBaseWidget {
  ECFormSwitchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: item.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(item.title ?? "",
                style: TextStyle(
                    color: ECColor.title, fontSize: item.titleFont ?? 16)),
            StreamBuilder<bool>(
                stream: item.changeStream,
                initialData: item.open,
                builder: ((context, snapshot) {
                  return CupertinoSwitch(
                      value: item.open,
                      activeColor: ECColor.main,
                      onChanged: ((value) {
                        item.open = value;
                        item.changeStream.add(item.open);
                        item.changeCall?.call(value);
                      }));
                }))
          ]),
          if (item.subTitle != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(item.subTitle ?? "",
                  style: TextStyle(fontSize: 12, color: ECColor.place)),
            ),
        ],
      ),
    );
  }
}

class ECFormSwitchWidgetVM<Input> with ECFormBaseWidgetVM, ListViewItemType {
  /// 子标题
  final String? subTitle;

  /// 默认是否打开
  bool open;

  /// switch切换的回调
  final Function(bool)? changeCall;

  /// switch切换的订阅
  late BehaviorSubject<bool> changeStream;

  /// 如果打开最终传入后台的值：影响 itemParam
  final dynamic openValue;

  /// 如果关闭传入后台的值：影响 itemParam
  final dynamic closeValue;

  ECFormSwitchWidgetVM(
      {String? title,
      double? titleFont,
      this.subTitle,
      bool ecRequired = false,
      required String paramKey,
      this.changeCall,
      ECFormOutCall<dynamic>? checkCall,
      String? errorString,
      bool enable = true,
      this.open = true,
      this.openValue = true,
      this.closeValue = false,
      String? value,
      EdgeInsets? padding,
      bool? showRedPoint}) {
    this.title = title;
    this.ecRequired = ecRequired;
    this.paramKey = paramKey;
    this.checkCall = checkCall;
    this.errorString = errorString;
    this.showRedPoint = showRedPoint;
    this.enable = enable;
    this.value = value;
    this.titleFont = titleFont ?? 16;
    this.padding = padding ?? const EdgeInsets.symmetric(horizontal: 16);
    changeStream = BehaviorSubject.seeded(open);
  }

  @override
  ListViewCellType<ListViewItemType> cellBuilder() {
    return ECFormSwitchWidget();
  }

  @override
  Map<String, dynamic> get itemParam {
    return {paramKey: open ? openValue : closeValue};
  }

  @override
  bool check() {
    if (!ecRequired) return true;
    if (checkCall == null) {
      return true;
    }

    bool isSuccess = checkCall!(value ?? '');
    errStream.add(!isSuccess);
    return isSuccess;
  }
}
