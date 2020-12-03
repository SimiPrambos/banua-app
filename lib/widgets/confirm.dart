import 'package:flutter/material.dart';

class Confirm extends StatelessWidget {
  final String title, message, okText, cancelText;

  const Confirm({
    Key key,
    this.title = "Hapus",
    this.message = "Apakah anda yakin ingin menghapus?",
    this.okText = "Hapus",
    this.cancelText = "Batal",
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [_ok(context), _cancel(context)],
    );
  }

  Widget _ok(BuildContext context) {
    return FlatButton(
      child: Text(
        okText,
        style: TextStyle(color: Colors.red),
      ),
      onPressed: () {
        Navigator.of(context).pop(true);
      },
    );
  }

  Widget _cancel(BuildContext context) {
    return FlatButton(
      child: Text(cancelText),
      onPressed: () {
        Navigator.of(context).pop(false);
      },
    );
  }
}

Future<bool> showConfirm({
  BuildContext context,
  Widget child,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return child;
    },
  );
}
