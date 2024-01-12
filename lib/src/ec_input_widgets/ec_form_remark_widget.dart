import '../core/ec_form_base_widget_vm.dart';
import 'package:ec_adapter/ec_adapter.dart';
import 'common/ec_form_title_widget.dart';
import '../core/ec_form_base_widget.dart';
import 'package:flutter/material.dart';
import '../core/ec_form_config.dart';
import '../core/ec_color.dart';

/// 备注
// ignore: must_be_immutable
class ECFormRemarkWidget extends StatelessWidget
    with ListViewCellType<ECFormRemarkWidgetVM>, ECFormBaseWidget {
  ECFormRemarkWidget({super.key, ECFormRemarkWidgetVM? vm}) {
    if (vm != null) item = vm;
  }

  @override
  Widget build(BuildContext context) {
    if (item.value != null) {
      item.textController.text = item.value as String;
    }

    return Container(
      // color: Colors.red,
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
          errorWidget(item,
              builder: (err) => Container(
                  padding:
                      const EdgeInsets.only(left: 12, right: 10, bottom: 5),
                  decoration: BoxDecoration(
                      color: item.enable ? Colors.white : ECColor.disInputBg,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(
                          width: 1,
                          color: err ? ECColor.errRed : ECColor.border)),
                  margin: EdgeInsets.zero,
                  height: item.height,
                  child: TextField(
                    controller: item.textController,
                    maxLength: item.maxLength,
                    maxLines: item.maxLines,
                    scrollPadding: EdgeInsets.zero,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(top: 5),
                      border: InputBorder.none,
                      hintText: item.hintText,
                    ),
                    onChanged: (value) {
                      item.value = value;
                    },
                    style: TextStyle(fontSize: 16, color: ECColor.title),
                  ))),
          // 底部错误提示
          bottomErrorWidget(item)
        ],
      ),
    );
  }
}

class ECFormRemarkWidgetVM<Input> with ECFormBaseWidgetVM, ListViewItemType {
  TextEditingController textController = TextEditingController();
  int maxLines;
  final String hintText;

  ECFormRemarkWidgetVM({
    required String paramKey,
    this.hintText = "请输入",
    this.maxLines = 30,
    String? title,
    bool ecRequired = true,
    double? height,
    ECFormOutCall<dynamic>? checkCall,
    String? errorString,
    bool enable = true,
    String? value,
    int? maxLength,
    EdgeInsets? padding,
    bool? showRedPoint,
  }) {
    this.title = title;
    this.ecRequired = ecRequired;
    this.paramKey = paramKey;
    this.height = height;
    this.checkCall = checkCall;
    this.errorString = errorString;
    this.showRedPoint = showRedPoint;
    this.enable = enable;
    this.value = value;
    this.height = height ?? 78;
    this.padding =
        padding ?? EdgeInsets.symmetric(horizontal: ECCormConfig.space);

    if (maxLength != null) {
      this.maxLength = maxLength;
    }

    if (value != null) {
      textController.text = value;
    }
  }

  @override
  ListViewCellType<ListViewItemType> cellBuilder() {
    return ECFormRemarkWidget();
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
