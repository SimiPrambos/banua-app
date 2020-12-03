import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:hive/hive.dart';
import 'package:ident/controllers/serial.controller.dart';
import 'package:ident/models/brand.model.dart';
import 'package:ident/pages/brand.page.dart';
import 'package:ident/widgets/confirm.dart';
import 'package:ident/widgets/search_bar.dart';

class BrandController {
  static Box<BrandModel> get box => Hive.box<BrandModel>(BrandModel.boxName);
  static List<BrandModel> get brands => box.values.toList();

  static bool isUnique(String name) {
    return brands.every((brand) => brand.name != name);
  }

  static void update(BrandModel current, Map<String, dynamic> value) {
    final data = BrandModel.fromMap(value);
    current.name = data.name;
    current.save();
  }

  static void onSearchPressed(BuildContext context) async {
    final brand = await showSearch(
      context: context,
      delegate: SearchBar<BrandModel>(
        box: BrandModel.boxName,
        filterBy: (item) => item.name,
        icon: Icon(FeatherIcons.tag),
      ),
    );

    if (brand != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => BrandDetail(data: brand),
        ),
      );
    }
  }

  static void onFabPressed(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      child: BrandDialog(),
    );
  }

  static void onSelected({
    BuildContext context,
    String action,
    List<BrandModel> selected,
  }) async {
    switch (action) {
      case "remove":
        final confirm = await showConfirm(
            context: context,
            child: Confirm(
                message:
                    "Semua serial terkait juga akan terhapus!\nApakah anda yakin?"));

        if (confirm) {
          selected.forEach((item) {
            final related = SerialController.byBrand(item.genKey);
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
