import 'package:ec_form/src/core/ec_form_base_widget_vm.dart';
import 'package:flutter/material.dart';

mixin ECFormBaseWidget {
  /// 当错误的时候，cell 底部红色错误提示
  Widget errorWidget(ECFormBaseWidgetVM item,
      {required Widget Function(bool err) builder}) {
    return StreamBuilder<bool>(
        stream: item.errStream,
        initialData: false,
        builder: ((context, snapshot) => builder(snapshot.requireData)));
  }

  /// 当值改变的时候更新 widget
  Widget valueChangeWidget<T>(ECFormBaseWidgetVM item,
      {required ECFormValueCall<T> builder}) {
    return StreamBuilder<Object>(
        stream: item.valueStream,
        initialData: '',
        builder: ((context, snapshot) => builder(snapshot.requireData as T)));
  }
}
