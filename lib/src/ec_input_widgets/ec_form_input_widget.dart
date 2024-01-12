import '../core/ec_form_base_widget_vm.dart';
import 'package:ec_adapter/ec_adapter.dart';
import '../core/ec_form_base_widget.dart';
import 'common/ec_form_title_widget.dart';
import 'package:flutter/material.dart';
import '../core/ec_form_config.dart';
import '../core/ec_text_filed.dart';
import '../core/ec_color.dart';

/// 输入框
// ignore: must_be_immutable
class ECFormInputWidget extends StatelessWidget
    with ListViewCellType<ECFormInputWidgetVM>, ECFormBaseWidget {
  ECFormInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    if (item.value != null) {
      item.inputController.text = item.value as String;
    }

    return Container(
      height: item.height,
      padding: item.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ECBaseFormTitleWidget(
            showRedPoint: item.visibilityRedPoint,
            title: item.title,
          ),
          const SizedBox(
            height: 8,
          ),
          item.enable
              ? errorWidget(item,
                  builder: (err) => ECTextFiled.aLineBorderInput(
                        isError: err,
                        maxLength: item.maxLength,
                        controller: item.inputController,
                        keyboardType: item.keyboardType,
                        height: 40,
                        onChanged: (p0) => item.value = p0,
                      ))
              : Container(
                  decoration: BoxDecoration(
                      color: ECColor.disInputBg,
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  height: 40,
                  child: Row(
                    children: [
                      Text("${item.value ?? ""}",
                          style: TextStyle(fontSize: 16, color: ECColor.place)),
                    ],
                  ),
                ),
          // 底部错误提示
          bottomErrorWidget(item)
        ],
      ),
    );
  }
}

class ECFormInputWidgetVM<Input> with ECFormBaseWidgetVM, ListViewItemType {
  /// 输入Controller
  late TextEditingController inputController = TextEditingController();

  /// 键盘类型
  final TextInputType? keyboardType;
  ECFormInputWidgetVM(
      {String? title,
      bool ecRequired = true,
      double? height,
      required String paramKey,
      ECFormOutCall<dynamic>? checkCall,
      String? errorString,
      bool enable = true,
      this.keyboardType,
      String? value,
      int? maxLength,
      EdgeInsets? padding,
      bool? showRedPoint}) {
    this.title = title;
    this.ecRequired = ecRequired;
    this.paramKey = paramKey;
    this.height = height;
    this.checkCall = checkCall;
    this.errorString = errorString;
    this.showRedPoint = showRedPoint;
    this.enable = enable;
    this.value = value;

    if (maxLength != null) {
      this.maxLength = maxLength;
    }
    this.padding =
        padding ?? EdgeInsets.symmetric(horizontal: ECCormConfig.space);
  }

  @override
  ListViewCellType<ListViewItemType> cellBuilder() {
    return ECFormInputWidget();
  }

  @override
  bool check() {
    if (!ecRequired) return true;
    if (checkCall == null) {
      bool isSuccess = value != null && (value as String).isNotEmpty;
      errStream.add(!isSuccess);
      return isSuccess;
    }

    bool isSuccess = checkCall!(value ?? '');
    errStream.add(!isSuccess);
    return isSuccess;
  }
}
