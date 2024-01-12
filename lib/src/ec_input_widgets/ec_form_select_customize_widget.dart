import 'common/ec_form_mixin_select_alert.dart';
import '../core/ec_form_base_widget_vm.dart';
import 'package:ec_adapter/ec_adapter.dart';
import 'common/ec_form_title_widget.dart';
import '../core/ec_form_base_widget.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import '../core/ec_border.dart';
import '../core/ec_color.dart';

/// 点击之后自定义数据（可以跳转等）
/// 不会收集param
// ignore: must_be_immutable
class ECFormInputSelectCustomizeWidget extends StatelessWidget
    with
        ListViewCellType<ECFormInputSelectCustomizeWidgetVM>,
        ECFormBaseWidget,
        ECFormMixinSelectAlert {
  ECFormInputSelectCustomizeWidget({super.key});

  Widget _eWidget(bool isErr) {
    if (item.errStream.value && item.errorString != null) {
      return Text(item.errorString!,
          style: TextStyle(fontSize: 12, color: ECColor.errRed));
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: item.padding ?? EdgeInsets.zero,
      child: Column(
        children: [
          ECBaseFormTitleWidget(
            title: item.title,
            showRedPoint: item.visibilityRedPoint,
            subTitle: item.subTitle,
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                  child: errorWidget(
                item,
                builder: (err) => GestureDetector(
                  onTap: () {
                    if (!item.enable) return;
                    _cellDidSelect();
                  },
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: 40,
                    ),
                    child: Container(
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
                          Expanded(child: _valueWidget()),
                          _dropDownIcon(),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
            ],
          ),
          SizedBox(
              height: 20,
              child: errorWidget(item, builder: (err) => _eWidget(err)))
        ],
      ),
    );
  }

  Visibility _dropDownIcon() {
    return Visibility(
      visible: item.enable,
      child: Container(
          padding: const EdgeInsets.only(left: 30),
          child: Icon(Icons.arrow_drop_down_outlined,
              color: ECColor.place, size: 16)),
    );
  }

  _cellDidSelect() {
    if (item.didClick != null) {
      item.didClick!(item);
    }
  }

  StreamBuilder<String?> _valueWidget() {
    return StreamBuilder<String?>(
        stream: item.selectSubject,
        initialData: item.value as String?,
        builder: ((context, snapshot) {
          String? selectItem = snapshot.data;
          return selectItem == null
              ? Text("请选择",
                  style: TextStyle(color: ECColor.place, fontSize: 16))
              : Text(selectItem,
                  style: TextStyle(color: ECColor.title, fontSize: 16));
        }));
  }
}

class ECFormInputSelectCustomizeWidgetVM<Input>
    with ECFormBaseWidgetVM, ListViewItemType {
  /// 选中信息
  String? subTitle;

  /// 选中的订阅
  BehaviorSubject<String?> selectSubject = BehaviorSubject.seeded(null);

  /// 选中的回调
  final Function(ECFormInputSelectCustomizeWidgetVM)? didClick;

  ECFormInputSelectCustomizeWidgetVM(
      {String? title,
      this.subTitle,
      bool ecRequired = true,
      required String paramKey,
      ECFormOutCall<dynamic>? checkCall,
      String? errorString,
      bool enable = true,
      String? value,
      EdgeInsets? padding,
      this.didClick,
      bool? showRedPoint}) {
    this.title = title;
    this.ecRequired = ecRequired;
    this.paramKey = paramKey;
    this.checkCall = checkCall;
    this.errorString = errorString;
    this.showRedPoint = showRedPoint;
    this.enable = enable;
    this.padding = padding ?? const EdgeInsets.symmetric(horizontal: 16);
    selectSubject.add(value);
  }

  @override
  ListViewCellType<ListViewItemType> cellBuilder() {
    return ECFormInputSelectCustomizeWidget();
  }

  @override
  Map<String, dynamic> get itemParam {
    return {};
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
}
