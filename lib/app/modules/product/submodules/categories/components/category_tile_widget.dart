import 'package:flutter/material.dart';

class CategoryTileWidget extends StatelessWidget {

  final String category;
  final IconData icon;
  final Function onPressed;

  CategoryTileWidget({
    @required this.category,
    @required this.icon,
    @required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return InkWell(
      onTap: onPressed,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(icon, size: 70.0, color: primaryColor),
            Text(category, style: TextStyle(fontSize: 24.0, color: primaryColor))
          ]
        )
      )
    );
  }
}