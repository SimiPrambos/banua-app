import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ident/constants.dart';
import 'package:ident/widgets/list_item.dart';
import 'package:substring_highlight/substring_highlight.dart';

class SearchBar<T> extends SearchDelegate<T> {
  final String box;
  final String Function(T item) filterBy;
  final Widget icon;

  SearchBar({this.box, this.filterBy, this.icon})
      : super(
          searchFieldLabel: "Cari...",
          searchFieldStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w100,
          ),
        );

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return super.appBarTheme(context).copyWith(
          primaryIconTheme: theme.primaryIconTheme.copyWith(
            color: theme.disabledColor,
          ),
          textTheme: theme.textTheme.copyWith(
            headline6: theme.textTheme.headline6.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w100,
            ),
          ),
        );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return query.isEmpty ? [] : [_clearButton];
  }

  Widget get _clearButton {
    return IconButton(
      icon: Icon(Icons.close),
      onPressed: () {
        query = "";
      },
    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Box<T> _box = Hive.box<T>(box);
    List<T> suggestions = _box.values
        .where((e) => filterBy(e).toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (query.isEmpty) {
      return Container();
    }

    if (suggestions.isEmpty) {
      return Container(
        child: Center(
          child: Text("Data tidak ditemukan."),
        ),
      );
    }

    return Padding(
      padding: kPadding,
      child: ListItems<T>(
        items: suggestions,
        leading: icon,
        title: (e) => SubstringHighlight(
          text: filterBy(e),
          term: query,
          textStyleHighlight: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: (e) {
          close(context, e);
        },
        action: false,
      ),
    );
  }
}
