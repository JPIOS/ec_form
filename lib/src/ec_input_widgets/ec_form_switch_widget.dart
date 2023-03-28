import 'package:ec_adapter/ec_adapter.dart';
import 'package:flutter/cupertino.dart' show CupertinoSwitch;
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../core/ec_color.dart';
import '../core/ec_form_base_widget.dart';
import '../core/ec_form_base_widget_vm.dart';

/// 备注
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                          if (item.changeCall != null) {
                            item.changeCall!(value);
                          }
                        }));
                  }))
            ],
          ),
          SizedBox(
            height: item.subTitle != null ? 8 : 0,
          ),
          item.subTitle == null
              ? Container()
              : Text(
                  item.subTitle ?? "",
                  style: TextStyle(fontSize: 12, color: ECColor.place),
                ),
        ],
      ),
    );
  }
}

class ECFormSwitchWidgetVM<Input> with ECFormBaseWidgetVM, ListViewItemType {
  final String? subTitle;
  bool open;
  final Function(bool)? changeCall;
  late BehaviorSubject<bool> changeStream;
  final dynamic openValue;
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
    this.padding = padding ?? EdgeInsets.symmetric(horizontal: 16);
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
