import 'package:flutter/material.dart'
    show BuildContext, Positioned, Stack, showDialog;
import 'package:ec_form/src/ec_input_widgets/common/ec_form_input_select_item.dart';
import '../../core/kd_list_sheet.dart';

mixin ECFormMixinSelectAlert {
  selectListAlert(BuildContext context,
      {required List<ECFormInputSelectItem> selectList,
      ECFormInputSelectItem? selectItem,
      Function(ECFormInputSelectItem)? selectCall}) async {
    showDialog(
        context: context,
        builder: (context) => Stack(
              children: [
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: ECListSheet.select(context,
                      selectValue: selectItem?.name,
                      list: selectList.map((e) => e.name).toList(),
                      indexSelect: ((p0) {
                    if (selectCall != null) {
                      selectCall(selectList[p0]);
                    }
                  })),
                ),
              ],
            ));
  }
}
