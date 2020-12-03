import 'package:flutter/material.dart';
import 'package:ident/constants.dart';
import 'package:provider/provider.dart';
import 'package:contextualactionbar/contextualactionbar.dart';

import 'package:ident/controllers/app.controller.dart';
import 'package:ident/controllers/brand.controller.dart';
import 'package:ident/controllers/category.controller.dart';
import 'package:ident/controllers/serial.controller.dart';

import 'package:ident/models/brand.model.dart';
import 'package:ident/models/category.model.dart';
import 'package:ident/models/serial.model.dart';

import 'package:ident/pages/brand.page.dart';
import 'package:ident/pages/category.page.dart';
import 'package:ident/pages/serial.page.dart';
import 'package:ident/widgets/appbar_mixin.dart';
import 'package:ident/widgets/tab_navigation.dart';

class AppNavigation extends StatefulWidget {
  @override
  _AppNavigationState createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> with AppBarMixin {
  @override
  Widget build(BuildContext context) {
    final _index = context.watch<AppController>().index;

    return ContextualScaffold<SerialModel>(
      contextualAppBar: serialAppBar,
      body: ContextualScaffold<CategoryModel>(
        contextualAppBar: categoryAppBar,
        body: ContextualScaffold<BrandModel>(
          contextualAppBar: brandAppBar,
          body: AppTabNavigation(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          switch (_index) {
            case 0:
              SerialController.onFabPressed(context);
              break;
            case 1:
              CategoryController.onFabPressed(context);
              break;
            case 2:
              BrandController.onFabPressed(context);
              break;
            default:
          }
        },
      ),
    );
  }
}

class AppTabNavigation extends StatefulWidget {
  @override
  _AppTabNavigationState createState() => _AppTabNavigationState();
}

class _AppTabNavigationState extends State<AppTabNavigation>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  bool _isSerialActionModeEnabled = false;
  bool _isCategoryActionModeEnabled = false;
  bool _isBrandActionModeEnabled = false;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this)
      ..addListener(() {
        context.read<AppController>().index = _controller.index;

        if (_controller.indexIsChanging && _isSerialActionModeEnabled ||
            _controller.index != 0) {
          ActionMode.disable<SerialModel>(context);
        }
        if (_controller.indexIsChanging && _isCategoryActionModeEnabled ||
            _controller.index != 1) {
          ActionMode.disable<CategoryModel>(context);
        }
        if (_controller.indexIsChanging && _isBrandActionModeEnabled ||
            _controller.index != 2) {
          ActionMode.disable<BrandModel>(context);
        }
      });

    ActionMode.enabledStream<SerialModel>(context).listen((event) {
      _isSerialActionModeEnabled = event;
    });
    ActionMode.enabledStream<CategoryModel>(context).listen((event) {
      _isCategoryActionModeEnabled = event;
    });
    ActionMode.enabledStream<BrandModel>(context).listen((event) {
      _isBrandActionModeEnabled = event;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (_, __) => [
          SliverAppBar(
            title: Text(kAppName),
            centerTitle: false,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    switch (_controller.index) {
                      case 0:
                        SerialController.onSearchPressed(context);
                        break;
                      case 1:
                        CategoryController.onSearchPressed(context);
                        break;
                      case 2:
                        BrandController.onSearchPressed(context);
                        break;
                      default:
                    }
                  },
                ),
              ),
            ],
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(TabBar(
              controller: _controller,
              indicatorWeight: 2,
              indicatorColor: Colors.white,
              tabs: [
                TabNavigation(title: "SERIAL"),
                TabNavigation(title: "KATEGORI"),
                TabNavigation(title: "MEREK"),
              ],
            )),
          ),
        ],
        body: TabBarView(
          controller: _controller,
          children: [
            SerialPage(),
            CategoryPage(),
            BrandPage(),
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: Theme.of(context).primaryColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
