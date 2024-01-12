import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

typedef ECFormOutCall<T> = bool Function(T out);
typedef ECFormValueCall<T> = Widget Function(T out);

/// base共用字段
mixin ECFormBaseWidgetVM {
  /// 是否必须传
  bool ecRequired = false;

  /// 入参
  String paramKey = '';

  /// value
  Object? value;

  BehaviorSubject<Object> valueStream = BehaviorSubject.seeded('');

  /// 是否显示红色*
  /// 如果是ecRequired，则默认会显示红点，
  /// 但是如果有传showRedPoint，则优先取该字段
  bool? showRedPoint;

  /// 表单标题
  String? title;
  double? titleFont;

  /// 表单高度
  double? height;

  /// 错误stream
  BehaviorSubject<bool> errStream = BehaviorSubject.seeded(false);

  /// 错误提示（在输入框/表单下方）
  /// 如果是可选择没有
  String? errorString;

  /// 校验函数
  /// 如果是可选，可以不用
  ECFormOutCall? checkCall;

  /// 检查校验
  bool check();

  /// 是否可编辑
  bool enable = true;

  /// 局部更新itemCell
  Function() updateItemCell = () {};

  /// 最大输入长度
  int maxLength = 10000;

  /// 输入框文字变化
  Function(dynamic)? onChange;

  /// 是否需要显示红色*
  bool get visibilityRedPoint => showRedPoint ?? ecRequired;

  /// 处理数据回选择
  requestCall() {}

  /// 提供一个子类可以定义的param
  Map<String, dynamic> get itemParam => {paramKey: value};

  /// 边距
  EdgeInsets? padding;

  /// 销毁坚挺，内部已经处理
  /// 外部需要可以重写这个方法，但是必须执行supper.dispose()
  disponse() {
    errStream.close();
    valueStream.close();
  }
}
