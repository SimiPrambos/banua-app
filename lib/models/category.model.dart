import 'package:hive/hive.dart';
part 'category.model.g.dart';

@HiveType(typeId: 0)
class CategoryModel extends HiveObject {
  static const String boxName = "categories";

  @HiveField(0)
  String name;
  @HiveField(1)
  String description;

  CategoryModel({this.name, this.description = ""});

  String get genKey {
    return name.toLowerCase();
  }

  static CategoryModel fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      name: map["name"],
      description: map["description"],
    );
  }
}
