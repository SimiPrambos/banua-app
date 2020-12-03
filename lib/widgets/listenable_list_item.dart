import 'package:contextualactionbar/contextualactionbar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ListenableListItem<T> extends StatelessWidget {
  final String boxName;
  final Widget leading;
  final Widget Function(T item) title, subtitle, trailing;
  final Function(T item) onTap;
  final bool action;
  const ListenableListItem({
    Key key,
    this.boxName,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.action = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<T>(boxName).listenable(),
      builder: (context, Box<T> box, _) => ListView.separated(
        itemCount: box.values.length,
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Divider(thickness: 1, height: 0),
        ),
        itemBuilder: (context, index) {
          T item = box.values.toList()[index];

          return action
              ? ContextualActionWidget<T>(
                  data: item,
                  child: _tile(item),
                )
              : _tile(item);
        },
      ),
    );
  }

  Widget _tile(T item) {
    return ListTile(
      leading: leading ?? null,
      title: title?.call(item) ?? null,
      subtitle: subtitle?.call(item) ?? null,
      trailing: trailing?.call(item) ?? null,
      onTap: () => onTap?.call(item),
      dense: false,
    );
  }
}

class ListenableBuilder<T> extends StatelessWidget {
  final String boxName;
  final Widget Function(BuildContext context, Box<T> box, Widget widget)
      builder;

  const ListenableBuilder({Key key, this.boxName, this.builder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<T>(boxName).listenable(),
      builder: builder,
    );
  }
}
