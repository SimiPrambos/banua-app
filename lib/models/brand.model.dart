import 'package:hive/hive.dart';
part 'brand.model.g.dart';

@HiveType(typeId: 2)
class BrandModel extends HiveObject {
  static const String boxName = "brands";

  @HiveField(0)
  String name;

  BrandModel({this.name});

  String get genKey {
    return name.toLowerCase();
  }

  static BrandModel fromMap(Map<String, dynamic> map) {
    return BrandModel(name: map["name"]);
  }
}
