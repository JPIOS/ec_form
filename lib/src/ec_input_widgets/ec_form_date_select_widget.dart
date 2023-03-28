import 'package:date_format/date_format.dart';
import 'package:ec_adapter/ec_adapter.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../core/ec_border.dart';
import '../core/ec_color.dart';
import '../core/ec_form_base_widget.dart';
import '../core/ec_form_base_widget_vm.dart';
import 'common/ec_form_title_widget.dart';

/// 选择时间
class ECFormDateSelectWidget extends StatelessWidget
    with ListViewCellType<ECFormDateSelectWidgetVM>, ECFormBaseWidget {
  ECFormDateSelectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    if (item.value != null && (item.value as String).isNotEmpty) {
      item.valueStream.add(item.value as String);
    }

    return Padding(
      padding: item.padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ECBaseFormTitleWidget(
            title: item.title,
            showRedPoint: item.visibilityRedPoint,
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (item.enable) {
                      _pickDate(context);
                    }
                  },
                  child: Container(
                    height: 40,
                    decoration: ECBorder(
                        color: item.enable ? ECColor.border : Colors.white,
                        bgColor:
                            item.enable ? Colors.white : ECColor.disInputBg),
                    padding: EdgeInsets.symmetric(horizontal: 12),
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
                              // color: Colors.red,
                              child: Icon(
                                Icons.date_range,
                                color: ECColor.place,
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              _foreverWidget(),
            ],
          ),
          SizedBox(
              height: 20,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: errorWidget(item, builder: (err) => _eWidget(err))))
        ],
      ),
    );
  }

  Widget _eWidget(bool isErr) {
    if (item.errStream.value) {
      return item.errorString == null
          ? Container()
          : Text(
              item.errorString!,
              style: TextStyle(fontSize: 12, color: ECColor.errRed),
            );
    }

    return Container();
  }

  /// 长期
  Visibility _foreverWidget() {
    return Visibility(
        visible: item.showForever,
        child: Row(
          children: [
            StreamBuilder<bool>(
                stream: item.foreverStream,
                initialData: false,
                builder: ((context, snapshot) => Checkbox(
                    value: snapshot.requireData,
                    activeColor: ECColor.main,
                    splashRadius: 16,
                    onChanged: (e) {
                      if (!item.enable) return;

                      item.foreverStream.add(e ?? false);
                      item.isForever = e ?? false;
                    }))),
            const Text(
              "长期",
              style: TextStyle(fontSize: 16),
            )
          ],
        ));
  }

  DateTime? _getCallDateTime(String? Function()? limitCall) {
    if (limitCall == null) return null;
    String? start = limitCall();
    if (start != null) {
      try {
        return DateTime.parse(start);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  _pickDate(BuildContext context) async {
    FocusScope.of(context).unfocus();
    // limitDate
    DateTime? limitStart = _getCallDateTime(item.limitStartCall);
    DateTime? limitEnd = _getCallDateTime(item.limitEndCall);

    DateTime nDate = DateTime.now();
    if (item.value != null && item.value is String) {
      try {
        nDate = DateTime.parse(item.value as String);
        // ignore: empty_catches
      } catch (e) {}

      /// 如果当前时间大于最大时间或者小于最小时间，会出问题
    }
    DateTime? result = await showDatePicker(
        context: context,
        cancelText: "取消",
        confirmText: "确认",
        initialDate: nDate,
        firstDate: limitStart ?? DateTime(1990),
        lastDate: limitEnd ?? DateTime(2100));

    // value赋值
    if (result != null) {
      item.value = formatDate(result, ['yyyy', '-', 'mm', '-', 'dd']);
      item.valueStream.add(item.value!);
      if (item.onChange != null) {
        item.onChange!(item.value);
      }
    }
  }
}

/// VM
class ECFormDateSelectWidgetVM<Input>
    with ECFormBaseWidgetVM, ListViewItemType {
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? Function()? limitStartCall;
  final String? Function()? limitEndCall;

  /// 永久可用
  final bool showForever;
  bool isForever;
  final String? foreverKey;
  BehaviorSubject<bool> foreverStream = BehaviorSubject.seeded(false);

  ECFormDateSelectWidgetVM(
      {String? title,
      bool ecRequired = true,
      double? height,
      required String paramKey,
      ECFormOutCall<dynamic>? checkCall,
      String? errorString,
      bool? showRedPoint,
      this.lastDate,
      this.firstDate,
      this.initialDate,
      this.limitStartCall,
      this.limitEndCall,
      bool enable = true,
      this.foreverKey,
      this.isForever = false,
      EdgeInsets? padding,
      Function(dynamic)? onChange,
      this.showForever = false}) {
    if (showForever && enable) {
      assert(foreverKey != null, "须传长期对应参数key");
    }

    this.title = title;
    this.ecRequired = ecRequired;
    this.paramKey = paramKey;
    this.height = height;
    this.checkCall = checkCall;
    this.enable = enable;
    this.showRedPoint = showRedPoint;
    this.onChange = onChange;
    this.padding = padding ?? const EdgeInsets.symmetric(horizontal: 16);
    if (ecRequired && errorString == null) {
      this.errorString = "请选择$title";
    } else {
      this.errorString = errorString;
    }

    if (showForever) {
      foreverStream.add(isForever);
    }
  }
  @override
  requestCall() {
    if (value != null) {
      valueStream.add(value!);
    }
  }

  @override
  ListViewCellType<ListViewItemType> cellBuilder() {
    return ECFormDateSelectWidget();
  }

  @override
  Map<String, dynamic> get itemParam {
    if (isForever) {
      return {foreverKey!: isForever ? "1" : "0"};
    }
    return super.itemParam;
  }

  @override
  bool check() {
    if (checkCall == null) {
      if (ecRequired) {
        bool isSuccess = value != null;

        /// 长期的
        if (showForever && isForever) {
          isSuccess = true;
        }
        errStream.add(!isSuccess);
        return isSuccess;
      }
      return true;
    }
    bool isSuccess = checkCall!(value ?? '');
    errStream.add(!isSuccess);
    return isSuccess;
  }
}
