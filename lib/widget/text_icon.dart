import 'package:flutter/material.dart';

class TextIcon extends StatelessWidget {
  final String title;
  final IconData icon;
  final String button;

  const TextIcon({Key key, this.title, this.icon, this.button}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            size: 18,
          ),
          SizedBox(width: 5),
          Text(
            title,
            style: theme.textTheme.subhead.copyWith(fontSize: 13),
          ),
        ],
      ),
    );
  }
}