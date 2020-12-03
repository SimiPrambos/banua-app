import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DialogForm extends StatelessWidget {
  final String title;
  final Widget child;
  final Function(Map<String, dynamic> result) onSave;
  DialogForm({this.title, this.child, this.onSave});

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FormBuilder(
            key: _fbKey,
            child: child,
          ),
        ],
      ),
      actions: [
        MaterialButton(
          child: Text("Batal"),
          onPressed: () {
            _reset();
            _close(context);
          },
        ),
        MaterialButton(
          child: Text("Simpan"),
          onPressed: () {
            if (_validate) {
              _save();
              _close(context);
            }
          },
        ),
      ],
    );
  }

  bool get _validate => _fbKey.currentState.saveAndValidate();

  void _reset() {
    _fbKey.currentState.reset();
  }

  void _save() {
    onSave(_fbKey.currentState.value);
  }

  void _close(BuildContext context) {
    Navigator.of(context).pop();
  }
}
