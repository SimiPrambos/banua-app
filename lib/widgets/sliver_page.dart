import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class SliverPage extends StatelessWidget {
  final String title, subtitle, trailing;
  final List<Widget> children;
  final Widget customTitle;

  const SliverPage(
      {Key key,
      this.title,
      this.subtitle,
      this.trailing,
      this.children,
      this.customTitle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: Icon(FeatherIcons.arrowLeft),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            floating: false,
            pinned: false,
            snap: false,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              title: customTitle ??
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            subtitle ?? "",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                              color: Colors.white70,
                            ),
                          ),
                          Text(
                            trailing ?? "",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
              titlePadding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              centerTitle: false,
            ),
            expandedHeight: size.height / 4,
          ),
          SliverList(delegate: SliverChildListDelegate.fixed(children ?? [])),
        ],
      ),
    );
  }
}
