import 'package:flutter/cupertino.dart';

//注意: 仅仅限制page的StatelessWidget，不可作为局部使用
class ECDisposeElement<T> extends StatelessElement {
  Function()? dispose;
  Function()? afterBulder;
  Function(Function())? ecUpdate;

  ECDisposeElement(StatelessWidget widget,
      {T Function()? builderVM, this.dispose, this.afterBulder, this.ecUpdate})
      : super(widget) {
    if (builderVM != null) {}
    if (afterBulder != null) {
      afterBulder!();
    }

    if (ecUpdate != null) {
      ecUpdate!(markNeedsBuild);
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
