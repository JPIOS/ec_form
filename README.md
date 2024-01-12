<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.

> 案例如下：
```

class _ECFormDemoPage extends ECFormBasePage {
  _ECFormDemoPageVM vm = _ECFormDemoPageVM();

  _ECFormDemoPage({super.key});

  @override
  String? get title => "表单提交";

  @override
  Widget? get leading => Container();

  @override
  Widget? get bottomWidget =>
      TextButton(onPressed: vm.commit, child: const Text("提交"));

  @override
  ECFormBasePageVM get pageVM => vm;
  @override
  setup(BuildContext context) {
    vm.loadData();
    return super.setup(context);
  }
}

class _ECFormDemoPageVM extends ECFormBasePageVM {
  /// 配置cell vm
  loadData() {
    datas.addAll([
      // 输入
      ECFormInputWidgetVM(
        paramKey: 'name',
        value: "不可修改名字",
        title: '名字',
        enable: false,
      ),

      ECFormInputWidgetVM(
        paramKey: 'name1',
        title: '名字',
        checkCall: (out) => out.length >= 2,
        errorString: "至少输入2个字",
      ),

      // 日期
      ECFormDateSelectWidgetVM(paramKey: 'startDate', title: "出发时间"),
      ECFormDateSelectWidgetVM(paramKey: 'endDate', title: "到达时间"),

      // 选择
      ECFormInputSelectWidgetVM(paramKey: 'cardId', title: "车子", selectList: [
        ECFormInputSelectItem(name: "宝马", value: "475993"),
        ECFormInputSelectItem(name: "奔驰", value: "976979")
      ]),

      // 选择(带单位)
      ECFormInputSelectUnitWidgetVM(
          paramKey: 'cardWight',
          title: "车子重",
          keyboardType: TextInputType.number,
          selectedItem: ECFormInputSelectItem(name: "吨", value: "1")),

      // 选择(带可选择单位)
      ECFormInputSelectUnitWidgetVM(
          paramKey: 'cardWight1',
          unitParamKey: "unitCode",
          title: "重量",
          selectedItem: ECFormInputSelectItem(name: "吨", value: "1"),
          unitCanSelect: true,
          keyboardType: TextInputType.number,
          unitSelectList: [
            ECFormInputSelectItem(name: "吨", value: "1"),
            ECFormInputSelectItem(name: "千克", value: "2")
          ]),

      // 备注
      ECFormRemarkWidgetVM(
        title: "添加备注",
        paramKey: 'remark',
        height: 100,
        maxLength: 50,
      ),

      // 展示
      ECFormSectionTitleWidgetVM(title: "大标题")
    ]);

    update();
  }

  commit() {
    // 如果有必选的参数没有值则底部出现红色提示 errorString
    if (!check()) return;

    // 收集的参数param
    Map<String, dynamic> param = getParam();

    debugPrint("收集的参数: ${param.toString()}");
  }
}

```