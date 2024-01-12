import 'package:flutter/cupertino.dart';
import '../../core/ec_color.dart';

/// 用于表单上方 title，如果是必选则会显示红色*
class ECBaseFormTitleWidget extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final bool showRedPoint;
  const ECBaseFormTitleWidget(
      {super.key, this.title, required this.showRedPoint, this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: title != null,
        child: Row(
          children: [
            Visibility(
              visible: showRedPoint,
              child: Text("* ",
                  style: TextStyle(color: ECColor.errRed, fontSize: 16)),
            ),
            Text(title ?? "",
                style: TextStyle(color: ECColor.hex("1D2129"), fontSize: 16)),
            SizedBox(
              width: subTitle == null ? 0 : 4,
            ),
            if (subTitle != null)
              Expanded(
                  child: Text(
                subTitle!,
                style: TextStyle(fontSize: 12, color: ECColor.place),
              ))
          ],
        ));
  }
}
