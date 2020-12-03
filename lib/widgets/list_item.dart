import 'package:contextualactionbar/contextualactionbar.dart';
import 'package:flutter/material.dart';

class ListItems<T> extends StatelessWidget {
  final List<T> items;
  final Widget leading;
  final Widget Function(T item) title, subtitle, trailing;
  final Function(T item) onTap;
  final bool action;
  const ListItems({
    Key key,
    this.items,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.action = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (context, index) => Divider(thickness: 1),
      itemBuilder: (context, index) {
        T item = items[index];

        return action
            ? ContextualActionWidget<T>(
                data: item,
                child: _tile(item),
              )
            : _tile(item);
      },
    );
  }

  Widget _tile(T item) {
    return ListTile(
      leading: leading ?? null,
      title: title?.call(item) ?? null,
      subtitle: subtitle?.call(item) ?? null,
      trailing: trailing?.call(item) ?? null,
      dense: false,
      onTap: () => onTap?.call(item),
    );
  }
}
