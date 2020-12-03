import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:hive/hive.dart';
import 'package:ident/controllers/serial.controller.dart';
import 'package:ident/models/category.model.dart';
import 'package:ident/pages/category.page.dart';
import 'package:ident/widgets/confirm.dart';
import 'package:ident/widgets/search_bar.dart';

class CategoryController {
  static Box<CategoryModel> get box =>
      Hive.box<CategoryModel>(CategoryModel.boxName);
  static List<CategoryModel> get categories => box.values.toList();

  static bool isUnique(String name) {
    return categories.every((category) => category.name != name);
  }

  static void update(CategoryModel current, Map<String, dynamic> value) {
    final data = CategoryModel.fromMap(value);
    current.name = data.name;
    current.description = data.description;
    current.save();
  }

  static void onFabPressed(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      child: CategoryDialog(),
    );
  }

  static void onSearchPressed(BuildContext context) async {
    final category = await showSearch(
      context: context,
      delegate: SearchBar<CategoryModel>(
        box: CategoryModel.boxName,
        filterBy: (item) => item.name,
        icon: Icon(FeatherIcons.package),
      ),
    );

    if (category != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CategoryDetail(data: category),
        ),
      );
    }
  }

  static void onSelected({
    BuildContext context,
    String action,
    List<CategoryModel> selected,
  }) async {
    switch (action) {
      case "remove":
        final confirm = await showConfirm(
          context: context,
          child: Confirm(
              message:
                  "Semua serial terkait juga akan terhapus!\nApakah anda yakin?"),
        );

        if (confirm) {
          selected.forEach((item) {
            final related = SerialController.byCategory(item.genKey);
            related.forEach((e) {
              SerialController.box.delete(e.key);
            });
            box.delete(item.key);
          });
        }
        break;
      default:
    }
  }
}
