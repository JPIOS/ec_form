import 'package:flutter/cupertino.dart';

//注意: 仅仅限制page的StatelessWidget，不可作为局部使用
class ECDisposeElement<T> extends StatelessElement {
  Function()? dispose;
  Function()? afterBulder;
  Function(Function())? ec_update;

  ECDisposeElement(StatelessWidget widget,
      {T Function()? builderVM, this.dispose, this.afterBulder, this.ec_update})
      : super(widget) {
    if (builderVM != null) {}
    if (afterBulder != null) {
      afterBulder!();
    }

    if (ec_update != null) {
      ec_update!(markNeedsBuild);
    }
  }

  @override
  void unmount() {
    super.unmount();
    if (dispose != null) {
      dispose!();
    }
  }
}
