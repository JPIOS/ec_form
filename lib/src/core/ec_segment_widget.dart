import 'package:flutter/material.dart';
import 'ec_border.dart';
import 'ec_color.dart';

typedef ECSegBottomBuilder = Widget Function();
typedef ECSegmentSelectCallback = void Function(int index);

enum ECSegmentStyle {
  // 居左
  left,
  // 居中
  center,
  // 平分 默认样式
  divide
}

// 配置模型
class ECSegmentConfig {
  // item样式 默认根据宽度平分
  ECSegmentStyle style;

  // 下标动画时间
  double animateDuration;

  // 标题之间距离
  double itemSpace;

  // 底部widget和标题之间的距离
  double bottonWidgetSpace;

  // 底部widget是否显示
  bool showBottonWidget;

  // 底部widget宽度
  double bottomWidgetWidth;

  // 底部widget高度
  double bottomWidgetHeight;

  // 底部widget圆角
  double bottomWidgetRadiu;

  // 底部widget背景颜色
  Color bottomWidgetColor;

  ECSegmentConfig({
    this.style = ECSegmentStyle.divide,
    this.animateDuration = 0.0,
    this.itemSpace = 20,
    this.bottonWidgetSpace = 1.0,
    this.showBottonWidget = true,
    this.bottomWidgetWidth = 40.0,
    this.bottomWidgetHeight = 2,
    this.bottomWidgetRadiu = 2.0,
  }) : bottomWidgetColor = ECColor.main;
}

class ECSegmentWidget extends StatefulWidget {
  /// 配置模型
  late ECSegmentConfig config;

  /// 底部标签样式
  ECSegBottomBuilder? bottomWidget;

  /// 高度
  double? height;

  /// 正常样式
  TextStyle normalStyle;

  /// 选中样式
  TextStyle selectStyle;

  /// 默认选中
  int defaultSelectIndex;

  /// 刷新使用
  int? selectIndex;

  /// 标题数据
  final List<String> titles;

  /// 点击回调
  final ECSegmentSelectCallback? didSelectIndex;

  /// ["我的","他的"] 如果设置红点 badgeValueList = [0,1],则第二个会有红点，0表示没有
  List<int>? badgeValueList;

  /// 钩子，会主动调用一次didSelectIndex回调
  final Function(Function(int index))? reselect;

  late _ECSegmentWidgetState _state;

  // 构造方法
  ECSegmentWidget(this.titles,
      {Key? key,
      this.height = 44.0,
      this.bottomWidget,
      this.defaultSelectIndex = 0,
      List<int>? badgeValueList,
      TextStyle? selectStyle,
      this.normalStyle = const TextStyle(
          color: Color(0xFF4E5969), fontSize: 14, fontWeight: FontWeight.w400),
      this.didSelectIndex,
      this.selectIndex,
      this.reselect,
      ECSegmentConfig? config})
      : config = config ?? ECSegmentConfig(),
        badgeValueList = badgeValueList ?? [],
        selectStyle = selectStyle ??
            TextStyle(
                color: ECColor.main, fontSize: 14, fontWeight: FontWeight.w500),
        super(key: key) {
    // segmentReset
  }

  @override
  // ignore: no_logic_in_create_state
  State<ECSegmentWidget> createState() {
    _state = _ECSegmentWidgetState();
    return _state;
  }
}

class _ECSegmentWidgetState extends State<ECSegmentWidget> {
  _ECSegmentWidgetState();

  /// 底部标签
  Widget? _bottomSinalWidget;

  /// 选中下标
  int selectdIndex = 0;

  ECSegmentConfig get _config => widget.config;

  @override
  void initState() {
    super.initState();
    selectdIndex = widget.defaultSelectIndex;

    if (widget.reselect != null) {
      widget.reselect!((int index) {
        if (widget.didSelectIndex != null) {
          widget.didSelectIndex!(index);
        }
        resetIndex(index);
      });
    }
  }

  @override
  void didUpdateWidget(ECSegmentWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.selectIndex == null) return;
    if (oldWidget.selectIndex != widget.selectIndex) {
      selectdIndex = widget.selectIndex!;
      setState(() {});
    }
  }

  resetIndex(int index) {
    selectdIndex = index;
    setState(() {});
  }

  double get _marginRight {
    return _config.style == ECSegmentStyle.divide ? 0 : _config.itemSpace;
  }

  /// bottom
  Widget _createBottomWidget(int index) {
    if (!_config.showBottonWidget || index != selectdIndex) return SizedBox();

    if (_bottomSinalWidget != null) return _bottomSinalWidget!;

    Widget temp;
    if (widget.bottomWidget != null) {
      temp = widget.bottomWidget!();
    } else {
      temp = Container(
          height: _config.bottomWidgetHeight,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_config.bottomWidgetRadiu),
              color: _config.bottomWidgetColor));
    }

    _bottomSinalWidget = Container(
      margin: EdgeInsets.only(top: _config.bottonWidgetSpace),
      child: temp,
    );
    return _bottomSinalWidget!;
  }

  Widget itemWidget(String title, int index) {
    return GestureDetector(
        onTap: () {
          if (widget.didSelectIndex != null) {
            widget.didSelectIndex!(index);
          }

          setState(() {
            selectdIndex = index;
          });
        },
        child: Container(
          decoration: ECBorder.defaultSideBorder(
              size: 1,
              types: [ECBorderType.bottom],
              color: index == selectdIndex ? ECColor.main : Colors.white,
              bgColor: Colors.white),
          child: Center(
            child: Text(
              title,
              style: index == selectdIndex
                  ? widget.selectStyle
                  : widget.normalStyle,
            ),
          ),
        ));
  }

  Widget _leftToRightItem(String title, int index) {
    return Container(
      margin: EdgeInsets.only(right: _marginRight),
      child: itemWidget(title, index),
    );
  }

  Widget _divideItem(String title, int index) {
    return Expanded(child: itemWidget(title, index));
  }

  List<Widget> _childrenItems() {
    return widget.titles.map((e) {
      int index = widget.titles.indexOf(e);
      if (_config.style == ECSegmentStyle.left) {
        return _leftToRightItem(e, index);
      }
      return _divideItem(e, index);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var list = _childrenItems();
    return Container(
      height: widget.height,
      decoration: ECBorder.defaultSideBorder(types: [ECBorderType.bottom]),
      child: _config.style == ECSegmentStyle.left
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: ((context, index) => list[index]),
              itemCount: list.length,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: _childrenItems()),
    );
  }
}
