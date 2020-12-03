import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ident/constants.dart';

class DetailPage extends StatefulWidget {
  final String title;
  final void Function(bool value) onActionChange;
  final void Function(Map<String, dynamic> value) onSave;
  final Widget child;

  DetailPage({
    Key key,
    this.title = "Detail",
    this.onActionChange,
    this.onSave,
    this.child,
  }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool editing = false;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(_leadingIcon),
          onPressed: () {
            _leadingFunction();
          },
        ),
        title: Text(widget.title),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(_actionIcon),
              iconSize: 22,
              onPressed: () {
                _actionFunction();
              },
            ),
          ),
        ],
      ),
      body: Container(
        padding: kPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FormBuilder(
              key: _fbKey,
              child: widget.child ?? Container(),
            ),
          ],
        ),
      ),
    );
  }

  IconData get _leadingIcon {
    return editing ? FeatherIcons.x : FeatherIcons.arrowLeft;
  }

  IconData get _actionIcon {
    return editing ? FeatherIcons.check : FeatherIcons.edit2;
  }

  bool get _validate => _fbKey.currentState.saveAndValidate();

  void toggleEditing() {
    setState(() {
      editing = !editing;
      widget.onActionChange(editing);
    });
  }

  void _leadingFunction() {
    if (editing) {
      toggleEditing();
    } else {
      Navigator.of(context).pop();
    }
  }

  void _actionFunction() {
    if (editing) {
      if (_validate) {
        widget.onSave?.call(_fbKey.currentState.value);
        Navigator.of(context).pop();
      }
    } else {
      toggleEditing();
    }
  }
}
