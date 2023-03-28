import 'package:ec_adapter/ec_adapter.dart';
import '../../ec_form.dart';

class ECFormBasePageVM {
  late ListViewAdapter adapter;
  List<ListViewItemType> datas = [];

  final ListViewBaseSectionItem _sectionVM = ListViewBaseSectionItem();

  setup(
      {ECFormSectionFooterHeaderWidget? top,
      ECFormSectionFooterHeaderWidget? footer}) {
    if (top != null) {
      // 插入top
      _sectionVM.headerBuilder = () => top;
    }

    //插入footer
    if (footer != null) {
      _sectionVM.footerBuilder = () => footer;
    }
  }

  ECFormBasePageVM() {
    adapter = ListViewAdapter(pageController: this);
  }

  /// 更新全部组件
  update() {
    _sectionVM.items.clear();
    _sectionVM.addItems(datas);
    adapter.reload(sections: [_sectionVM]);
    // adapter.reloadSingleCell(datas);
  }

  /// 获取表单上传参数
  Map<String, dynamic> getParam() {
    var maps = whereFormWidgetVM.map((e) => e.itemParam);

    // 添加到map
    Map<String, dynamic> map = {};
    maps.forEach(map.addAll);
    return map;
  }

  /// 检查全部可用性
  bool check() {
    bool isAllSuccess = whereFormWidgetVM
        .map((e) => e.check())
        .reduce((value, element) => value && element);
    return isAllSuccess;
  }

  /// 会执行销毁操作
  /// 继承如果实现该方法
  /// 必须执行super.disponsed();
  disponsed() {
    for (var element in whereFormWidgetVM) {
      element.disponse();
    }
  }

  List<ECFormBaseWidgetVM> get whereFormWidgetVM {
    return datas.whereType<ECFormBaseWidgetVM>().toList();
  }
}
