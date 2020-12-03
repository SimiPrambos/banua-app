import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ident/controllers/brand.controller.dart';
import 'package:ident/controllers/category.controller.dart';
import 'package:ident/controllers/serial.controller.dart';
import 'package:ident/models/brand.model.dart';
import 'package:ident/models/category.model.dart';
import 'package:ident/models/serial.model.dart';
import 'package:ident/widgets/detail_page.dart';
import 'package:ident/widgets/dialog_form.dart';
import 'package:ident/widgets/listenable_list_item.dart';

class SerialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListenableListItem<SerialModel>(
      boxName: SerialModel.boxName,
      leading: Icon(FeatherIcons.cpu),
      title: (item) => Text(item.name.toUpperCase()),
      subtitle: (item) => Text("Merek : ${item.brand.name}"),
      trailing: (item) => Text(
        item.category.name,
        style: TextStyle(fontSize: 20),
      ),
      onTap: (item) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => SerialDetail(data: item)),
        );
      },
    );
  }
}

class SerialDialog extends StatelessWidget {
  final List<CategoryModel> _categories = CategoryController.categories;
  final List<BrandModel> _brands = BrandController.brands;

  @override
  Widget build(BuildContext context) {
    return DialogForm(
      title: "Tambah Serial",
      onSave: (value) {
        final serial = SerialModel.fromMap(value);
        SerialController.box.add(serial);
      },
      child: SerialForm(
        categories: _categories,
        brands: _brands,
      ),
    );
  }
}

class SerialForm extends StatelessWidget {
  final bool write, update;
  final String currentName;
  final int currentCategoryIndex;
  final List<CategoryModel> categories;
  final List<BrandModel> brands;
  final int currentBrandIndex;

  const SerialForm({
    Key key,
    this.write = true,
    this.update = false,
    this.currentName = "",
    this.currentCategoryIndex,
    this.categories,
    this.currentBrandIndex,
    this.brands,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormBuilderTextField(
          autofocus: true,
          attribute: "name",
          initialValue: currentName,
          readOnly: !write,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            labelText: "Kode",
            hintText: "KJASH98AKJHS-UASY",
          ),
          textCapitalization: TextCapitalization.characters,
          validators: [
            FormBuilderValidators.required(),
            (val) {
              bool _unique = update ? true : SerialController.isUnique(val);
              if (!_unique) {
                return "Kode serial sudah ada!";
              }
              return null;
            },
          ],
        ),
        FormBuilderDropdown(
          attribute: "category",
          initialValue: currentCategoryIndex != null
              ? categories[currentCategoryIndex]
              : null,
          readOnly: !write,
          decoration: InputDecoration(labelText: "Kategori"),
          hint: Text("Pilih Kategori"),
          validators: [FormBuilderValidators.required()],
          items: categories.map((category) {
            return DropdownMenuItem(
              value: category,
              child: Text(
                  "${category.name.toUpperCase()} - ${category.description}"),
            );
          }).toList(),
        ),
        FormBuilderDropdown(
          attribute: "brand",
          initialValue:
              currentBrandIndex != null ? brands[currentBrandIndex] : null,
          readOnly: !write,
          decoration: InputDecoration(labelText: "Merek"),
          hint: Text("Pilih Merek"),
          validators: [FormBuilderValidators.required()],
          items: brands.map((brand) {
            return DropdownMenuItem(
              value: brand,
              child: Text(brand.name.toUpperCase()),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class SerialDetail extends StatefulWidget {
  final SerialModel data;

  const SerialDetail({Key key, this.data}) : super(key: key);

  @override
  _SerialDetailState createState() => _SerialDetailState();
}

class _SerialDetailState extends State<SerialDetail> {
  bool editing = false;

  @override
  Widget build(BuildContext context) {
    final List<CategoryModel> _categories = CategoryController.categories;
    final List<BrandModel> _brands = BrandController.brands;
    final serial = widget.data;
    final currentCategoryIndex =
        _categories.indexWhere((e) => e.genKey == serial.category.genKey);
    final currentBrandIndex =
        _brands.indexWhere((e) => e.genKey == serial.brand.genKey);

    return DetailPage(
      title: "Serial",
      onActionChange: (val) {
        setState(() {
          editing = val;
        });
      },
      onSave: (val) {
        SerialController.update(serial, val);
      },
      child: SerialForm(
        currentName: serial.name,
        categories: _categories,
        currentCategoryIndex: currentCategoryIndex,
        brands: _brands,
        currentBrandIndex: currentBrandIndex,
        write: editing,
        update: true,
      ),
    );
  }
}
