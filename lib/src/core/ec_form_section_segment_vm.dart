import 'package:ec_adapter/ec_adapter.dart';
import 'package:flutter/material.dart';
import 'ec_segment_widget.dart';

/// 头部一个固定的segment
class ECFormSectionSegmentConfig {
  String title;
  List<ListViewItemType> items;
  ECFormSectionSegmentConfig({required this.title, required this.items});
}

class ECFormSectionSegmentVM with ListViewSectionItemType {
  final List<ECFormSectionSegmentConfig> configs;
  final List<String> titles;
  ECFormSectionSegmentVM({required this.configs})
      : titles = configs.map((e) => e.title).toList() {
    // 默认添加第一个
    if (configs.length > 0) {
      items.addAll(configs[0].items);
    }
  }

  @override
  ListViewHeaderFooterType<ListViewSectionItemType> Function()?
      get headerBuilder {
    return () => ECSegmentAdaptWidget(
          titles: titles,
          didSelectIndex: (index) {
            items.clear();
            items.addAll(configs[index].items);
            reloadList!();
          },
        );
  }
}

// ignore: must_be_immutable
class ECSegmentAdaptWidget extends StatelessWidget
    with ListViewHeaderFooterType<ECFormSectionSegmentVM> {
  final List<String> titles;
  void Function(int)? didSelectIndex;
  ECSegmentAdaptWidget({super.key, required this.titles, this.didSelectIndex});

  @override
  Widget build(BuildContext context) {
    return ECSegmentWidget(
      titles,
      didSelectIndex: didSelectIndex,
    );
  }
}
