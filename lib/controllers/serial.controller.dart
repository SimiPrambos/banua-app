import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:hive/hive.dart';
import 'package:ident/models/serial.model.dart';
import 'package:ident/pages/serial.page.dart';
import 'package:ident/widgets/confirm.dart';
import 'package:ident/widgets/search_bar.dart';

class SerialController {
  static Box<SerialModel> get box => Hive.box<SerialModel>(SerialModel.boxName);
  static List<SerialModel> get serials => box.values.toList();

  static bool isUnique(String name) {
    return serials.every((serial) => serial.name != name);
  }

  static void update(SerialModel current, Map<String, dynamic> value) {
    final data = SerialModel.fromMap(value);
    current.name = data.name;
    current.category = data.category;
    current.brand = data.brand;
    current.save();
  }

  static Iterable<SerialModel> byCategory(String genKey) {
    return serials.where((serial) => serial.category.genKey == genKey);
  }

  static Iterable<SerialModel> byBrand(String genKey) {
    return serials.where((serial) => serial.brand.genKey == genKey);
  }

  static void onFabPressed(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      child: SerialDialog(),
    );
  }

  static void onSearchPressed(BuildContext context) async {
    final serial = await showSearch(
      context: context,
      delegate: SearchBar<SerialModel>(
        box: SerialModel.boxName,
        filterBy: (item) => item.name,
        icon: Icon(FeatherIcons.cpu),
      ),
    );

    if (serial != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SerialDetail(data: serial),
        ),
      );
    }
  }

  static void onSelected({
    BuildContext context,
    String action,
    List<SerialModel> selected,
  }) async {
    switch (action) {
      case "remove":
        final confirm = await showConfirm(
          context: context,
          child: Confirm(),
        );

        if (confirm) {
          selected.forEach((e) {
            box.delete(e.key);
          });
        }
        break;
      default:
    }
  }
}
