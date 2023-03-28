import 'package:flutter/material.dart';
import 'package:ec_adapter/ec_adapter.dart';

// ignore: must_be_immutable
class ECFormSectionFooterHeaderWidget extends StatelessWidget
    with ListViewHeaderFooterType {
  final Widget content;
  ECFormSectionFooterHeaderWidget(this.content, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return content;
  }
}
