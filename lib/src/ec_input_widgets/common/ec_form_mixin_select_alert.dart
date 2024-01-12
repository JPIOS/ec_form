import 'package:ec_form/src/ec_input_widgets/common/ec_form_input_select_item.dart';
import 'package:flutter/material.dart'
    show BuildContext, Positioned, Stack, showDialog;
import 'package:flutter/widgets.dart';
import '../../core/kd_list_sheet.dart';

mixin ECFormMixinSelectAlert {
  selectListAlert(BuildContext context,
      {required List<ECFormInputSelectItem> selectList,
      ECFormInputSelectItem? selectItem,
      Function(ECFormInputSelectItem)? selectCall}) async {
    showDialog(
        useSafeArea: false,
        context: context,
        builder: (context) => Stack(
              children: [
                Positioned(
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: ECListSheet.select(context,
                      selectValue: selectItem?.name,
                      list: selectList.map((e) => e.name).toList(),
                      indexSelect: ((p0) {
                    selectCall?.call(selectList[p0]);
                  })),
                ),
              ],
            ));
  }
}
