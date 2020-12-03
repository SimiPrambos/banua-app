import 'package:hive/hive.dart';
import 'package:ident/models/brand.model.dart';
import 'package:ident/models/category.model.dart';
part 'serial.model.g.dart';

@HiveType(typeId: 1)
class SerialModel extends HiveObject {
  static const String boxName = "serials";

  @HiveField(0)
  String name;
  @HiveField(1)
  CategoryModel category;
  @HiveField(2)
  BrandModel brand;

  SerialModel({this.name, this.category, this.brand});

  String get genKey {
    return name.toLowerCase();
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "category": category,
      "brand": brand,
    };
  }

  static SerialModel fromMap(Map<String, dynamic> map) {
    return SerialModel(
      name: map["name"],
      category: map["category"],
      brand: map["brand"],
    );
  }
}
