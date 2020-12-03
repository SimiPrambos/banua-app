import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ident/controllers/category.controller.dart';
import 'package:ident/controllers/serial.controller.dart';
import 'package:ident/models/category.model.dart';
import 'package:ident/widgets/detail_page.dart';
import 'package:ident/widgets/dialog_form.dart';
import 'package:ident/widgets/listenable_list_item.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListenableListItem<CategoryModel>(
      boxName: CategoryModel.boxName,
      leading: Icon(FeatherIcons.package),
      title: (item) => Text(item.name.toUpperCase()),
      subtitle: (item) => Text(item.description),
      trailing: (item) => Text("${_serialCount(item)} serial"),
      onTap: (item) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CategoryDetail(data: item),
          ),
        );
      },
    );
  }

  int _serialCount(CategoryModel category) {
    return SerialController.byCategory(category.genKey).length;
  }
}

class CategoryDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DialogForm(
      title: "Tambah Kategori",
      onSave: (value) {
        final category = CategoryModel.fromMap(value);
        CategoryController.box.add(category);
      },
      child: CategoryForm(),
    );
  }
}

class CategoryForm extends StatelessWidget {
  final bool write, update;
  final CategoryModel initialValue;

  const CategoryForm({
    Key key,
    this.write = true,
    this.update = false,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormBuilderTextField(
          autofocus: true,
          attribute: "name",
          readOnly: !write,
          initialValue: initialValue != null ? initialValue.name : "",
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: "Nama",
            hintText: "A++",
          ),
          textCapitalization: TextCapitalization.characters,
          validators: [
            FormBuilderValidators.required(),
            (val) {
              bool _unique = update ? true : CategoryController.isUnique(val);
              if (!_unique) {
                return "Nama kategori sudah ada!";
              }
              return null;
            },
          ],
        ),
        FormBuilderTextField(
          attribute: "description",
          readOnly: !write,
          initialValue: initialValue != null ? initialValue.description : "",
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            labelText: "Deskripsi",
            hintText: "Harga 10k",
          ),
        ),
      ],
    );
  }
}

class CategoryDetail extends StatefulWidget {
  final CategoryModel data;
  const CategoryDetail({Key key, this.data}) : super(key: key);

  @override
  _CategoryDetailState createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  bool editing = false;

  @override
  Widget build(BuildContext context) {
    final category = widget.data;

    return DetailPage(
      title: "Kategori",
      onActionChange: (val) {
        setState(() {
          editing = val;
        });
      },
      onSave: (val) {
        CategoryController.update(category, val);
      },
      child: CategoryForm(
        initialValue: category,
        write: editing,
        update: true,
      ),
    );
  }
}
