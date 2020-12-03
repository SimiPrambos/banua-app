import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ident/controllers/brand.controller.dart';
import 'package:ident/controllers/serial.controller.dart';
import 'package:ident/models/brand.model.dart';
import 'package:ident/widgets/detail_page.dart';
import 'package:ident/widgets/dialog_form.dart';
import 'package:ident/widgets/listenable_list_item.dart';

class BrandPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListenableListItem<BrandModel>(
      boxName: BrandModel.boxName,
      leading: Icon(FeatherIcons.package),
      title: (item) => Text(item.name.toUpperCase()),
      trailing: (item) => Text("${_serialCount(item)} serial"),
      onTap: (item) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BrandDetail(data: item),
          ),
        );
      },
    );
  }

  int _serialCount(BrandModel brand) {
    return SerialController.byBrand(brand.genKey).length;
  }
}

class BrandDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DialogForm(
      title: "Tambah Merek",
      onSave: (value) {
        final brand = BrandModel.fromMap(value);
        BrandController.box.add(brand);
      },
      child: BrandForm(),
    );
  }
}

class BrandForm extends StatelessWidget {
  final bool write, update;
  final BrandModel initialValue;

  const BrandForm({
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
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            labelText: "Nama",
            hintText: "Samsung..",
          ),
          textCapitalization: TextCapitalization.characters,
          validators: [
            FormBuilderValidators.required(),
            (val) {
              bool _unique = update ? true : BrandController.isUnique(val);
              if (!_unique) {
                return "Nama merek sudah ada!";
              }
              return null;
            },
          ],
        ),
      ],
    );
  }
}

class BrandDetail extends StatefulWidget {
  final BrandModel data;
  const BrandDetail({Key key, this.data}) : super(key: key);

  @override
  _BrandDetailState createState() => _BrandDetailState();
}

class _BrandDetailState extends State<BrandDetail> {
  bool editing = false;

  @override
  Widget build(BuildContext context) {
    final category = widget.data;

    return DetailPage(
      title: "Merek",
      onActionChange: (val) {
        setState(() {
          editing = val;
        });
      },
      onSave: (val) {
        BrandController.update(category, val);
      },
      child: BrandForm(
        initialValue: category,
        write: editing,
        update: true,
      ),
    );
  }
}
