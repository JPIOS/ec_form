import 'package:flutter/cupertino.dart';

//注意: 仅仅限制page的StatelessWidget，不可作为局部使用
class ECDisposeElement<T> extends StatelessElement {
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

  /// unmount 销毁回调
  Function()? dispose;

  /// widget 构建之后的回调
  Function()? afterBulder;

  /// 更新整个 widget
  Function(Function())? ecUpdate;

  @override
  void unmount() {
    super.unmount();
    if (dispose != null) {
      dispose!();
    }
  }
}
