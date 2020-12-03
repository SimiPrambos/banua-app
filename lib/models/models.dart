import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ident/models/brand.model.dart';
import 'package:ident/models/category.model.dart';
import 'package:ident/models/serial.model.dart';

initHive() async {
  await Hive.initFlutter();
  registerAdapters();
  await openBoxes();
}

registerAdapters() {
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(SerialModelAdapter());
  }
  if (!Hive.isAdapterRegistered(2)) {
    Hive.registerAdapter(BrandModelAdapter());
  }
}

openBoxes() async {
  if (!Hive.isBoxOpen(CategoryModel.boxName)) {
    await Hive.openBox<CategoryModel>(CategoryModel.boxName);
  }
  if (!Hive.isBoxOpen(SerialModel.boxName)) {
    await Hive.openBox<SerialModel>(SerialModel.boxName);
  }
  if (!Hive.isBoxOpen(BrandModel.boxName)) {
    await Hive.openBox<BrandModel>(BrandModel.boxName);
  }
}

Box<SerialModel> get serialBox => Hive.box<SerialModel>(SerialModel.boxName);
Box<CategoryModel> get categoryBox =>
    Hive.box<CategoryModel>(CategoryModel.boxName);
Box<BrandModel> get brandBox => Hive.box<BrandModel>(BrandModel.boxName);
