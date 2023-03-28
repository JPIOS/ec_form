import 'package:ec_adapter/ec_adapter.dart';
import 'package:flutter/material.dart';
import 'ec_dispose_less_element.dart';
import '../../ec_form.dart';

// ignore: must_be_immutable
class ECFormBasePage extends StatelessWidget with ECFormBasePageType {
  late ECDisposeElement _element;

  ECFormBasePage({super.key}) {
    _insetHeaderFooter();
    _element = ECDisposeElement(this, dispose: () {
      pageVM.disponsed();
    });
  }

  /// 子weidget继承之后，必须执行
  /// return super.createElement();
  /// 确保element不被继承者替换
  @override
  StatelessElement createElement() {
    Future.delayed(const Duration(milliseconds: 200))
        .then((value) => setupElement(_element));
    return _element;
  }

  /// 配置头部和底部
  /// 这个是可以跟着滚动的
  _insetHeaderFooter() {
    if (topWidget != null) {
      pageVM.setup(top: ECFormSectionFooterHeaderWidget(topWidget!));
    }

    bool hasBtm = bottomWidget != null;
    pageVM.setup(
        footer: ECFormSectionFooterHeaderWidget(Column(
      children: [
        hasBtm ? bottomWidget! : Container(),
        const SizedBox(height: 20)
      ],
    )));
  }

  @override
  Widget build(BuildContext context) {
    setup(context);
    // ignore: unnecessary_null_comparison
    assert(pageVM != null, '请配置PageVM');

    EdgeInsets padding = kdPadding ?? EdgeInsets.zero;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: titleWiget ??
            Text(
              title ?? '',
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
        leading: leading ??
            defualtBack(onTap: () {
              if (backClick != null) {
                backClick!();
              }
            }),
        centerTitle: true,
        actions: actions,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: positionTopWidget ?? Container(),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: positionTopHeight,
              child: AdapterListViewBuilder.builder(pageVM.adapter,
                  primary: true, padding: padding, reloadCall: () {
                _element.markNeedsBuild();
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget defualtBack({void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: const Icon(
        Icons.arrow_back_ios_rounded,
        color: Colors.black,
      ),
    );
  }

  /// 头部固定
  Widget? get positionTopWidget => null;
  double get positionTopHeight => 0.0;

  setup(BuildContext context) {}

  /// 按照需求做继承即可
  /// 子类一定要实现这个
  @override
  ECFormBasePageVM get pageVM => throw UnimplementedError();

  @override
  String? get title => null;

  @override
  Widget? get titleWiget => null;

  @override
  Widget? get bottomWidget => null;

  @override
  Widget? get topWidget => null;

  @override
  List<Widget>? get actions => null;

  @override
  Widget? get leading => null;

  @override
  EdgeInsets? get kdPadding => null;

  @override
  Function()? get backClick => null;

  @override
  setupElement(StatelessElement element) {}
}

mixin ECFormBasePageType {
  /// 标题
  String? get title;

  /// 标题
  Widget? get titleWiget;

  // 上部分的widget
  Widget? get topWidget;

  /// 底部自定义
  Widget? get bottomWidget;

  /// 右上角
  List<Widget>? get actions;

  /// 左上角
  Widget? get leading;

  /// 提供子类初始化数据
  setupElement(StatelessElement element);

  /// pageVm
  /// page 需要自己初始化并持有该pageVm
  /// 并不建议这里返回pageVM的构造函数
  ECFormBasePageVM get pageVM;

  /// padding
  EdgeInsets? kdPadding;

  Function()? get backClick;
}
