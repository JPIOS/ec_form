import 'package:flutter/cupertino.dart';
import 'ec_color.dart';

class ECTextFiled {
  /// 输入框
  /// 手机号码输入
  /// 11位
  static Widget phone({
    Widget? prefix,
    TextEditingController? controller,
    Function(String)? onChanged,
    bool isError = false,
    TextStyle? style,
    bool? enabled,
  }) {
    return aLineInput(
        prefix: prefix,
        controller: controller,
        onChanged: onChanged,
        style: style,
        enabled: enabled,
        clearButtonMode: OverlayVisibilityMode.editing,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(
                width: 1,
                color: isError ? ECColor.errRed : const Color(0xFFC9CDD4))));
  }

  /// 单行输入，有边框
  static Widget aLineBorderInput({
    Widget? prefix,
    TextEditingController? controller,
    TextInputType? keyboardType,
    Function(String)? onChanged,
    bool obscureText = false,
    bool isError = false,
    TextStyle? style,
    int? maxLength,
    double? height,
    bool? enabled,
  }) {
    return aLineInput(
        controller: controller,
        onChanged: onChanged,
        obscureText: obscureText,
        clearButtonMode: OverlayVisibilityMode.editing,
        style: style,
        maxLength: maxLength,
        height: height,
        keyboardType: keyboardType,
        enabled: enabled,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(
                width: 1,
                color: isError ? ECColor.errRed : const Color(0xFFC9CDD4))));
  }

  /// 单行输入
  /// 限制输入长度
  static Widget aLineInput(
      {int? maxLength,
      TextInputType? keyboardType,
      OverlayVisibilityMode clearButtonMode = OverlayVisibilityMode.never,
      TextEditingController? controller,
      String placeholder = "请输入",
      Function(String)? onChanged,
      Widget? prefix,
      BoxDecoration? decoration,
      bool obscureText = false,
      TextStyle? style,
      TextStyle? placeholderStyle,
      Key? key,
      double? height,
      int maxLines = 1,
      bool? enabled}) {
    return SizedBox(
      height: height ?? 57,
      child: CupertinoTextField(
        key: key,
        prefix: prefix,
        cursorColor: ECColor.main,
        controller: controller,
        maxLength: maxLength,
        maxLines: maxLines,
        placeholder: placeholder,
        style: style ?? const TextStyle(fontSize: 16),
        onChanged: onChanged,
        obscureText: obscureText,
        enabled: enabled,

        // padding: EdgeInsets.all(16),
        placeholderStyle:
            placeholderStyle ?? TextStyle(color: ECColor.place, fontSize: 16),
        keyboardType: keyboardType,
        clearButtonMode: clearButtonMode,
        decoration: decoration,
        textCapitalization: TextCapitalization.words,
      ),
    );
  }
}
