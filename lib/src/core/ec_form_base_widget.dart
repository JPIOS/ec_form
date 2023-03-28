import 'package:ec_form/src/core/ec_form_base_widget_vm.dart';
import 'package:flutter/material.dart';

mixin ECFormBaseWidget {
  Widget errorWidget(ECFormBaseWidgetVM item,
      {required Widget Function(bool err) builder}) {
    return StreamBuilder<bool>(
        stream: item.errStream,
        initialData: false,
        builder: ((context, snapshot) => builder(snapshot.requireData)));
  }

  Widget valueChangeWidget<T>(ECFormBaseWidgetVM item,
      {required ECFormValueCall<T> builder}) {
    return StreamBuilder<Object>(
        stream: item.valueStream,
        initialData: '',
        builder: ((context, snapshot) => builder(snapshot.requireData as T)));
  }
}
