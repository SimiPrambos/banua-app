import 'package:flutter/material.dart';

class TabNavigation extends StatelessWidget {
  final String title;
  final int count;

  const TabNavigation({Key key, this.title, this.count = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [Text(title, style: TextStyle(fontSize: 13)), _badge],
      ),
    );
  }

  Widget get _badge {
    if (count <= 0) return Container();

    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 5),
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Text(
        count.toString(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 10,
        ),
      ),
    );
  }
}
