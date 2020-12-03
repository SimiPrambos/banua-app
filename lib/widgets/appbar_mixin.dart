import 'package:contextualactionbar/contextualactionbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:ident/controllers/brand.controller.dart';
import 'package:ident/controllers/category.controller.dart';
import 'package:ident/controllers/serial.controller.dart';
import 'package:ident/models/brand.model.dart';
import 'package:ident/models/category.model.dart';
import 'package:ident/models/serial.model.dart';

mixin AppBarMixin<Page extends StatefulWidget> on State<Page> {
  ContextualAppBar<SerialModel> get serialAppBar {
    return ContextualAppBar(
      elevation: 0.0,
      counterBuilder: (int count) => Text("$count"),
      closeIcon: Icons.arrow_back,
      contextualActions: [
        ContextualAction(
          itemsHandler: (selected) {
            SerialController.onSelected(
              context: context,
              action: "remove",
              selected: selected,
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(FeatherIcons.trash, size: 20),
          ),
        ),
      ],
    );
  }

  ContextualAppBar<CategoryModel> get categoryAppBar {
    return ContextualAppBar(
      elevation: 0.0,
      counterBuilder: (int count) => Text("$count"),
      closeIcon: Icons.arrow_back,
      contextualActions: [
        ContextualAction(
          itemsHandler: (selected) {
            CategoryController.onSelected(
              context: context,
              action: "remove",
              selected: selected,
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(FeatherIcons.trash, size: 20),
          ),
        ),
      ],
    );
  }

  ContextualAppBar<BrandModel> get brandAppBar {
    return ContextualAppBar(
      elevation: 0.0,
      counterBuilder: (int count) => Text("$count"),
      closeIcon: Icons.arrow_back,
      contextualActions: [
        ContextualAction(
          itemsHandler: (selected) {
            BrandController.onSelected(
              context: context,
              action: "remove",
              selected: selected,
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(FeatherIcons.trash, size: 20),
          ),
        ),
      ],
    );
  }
}
