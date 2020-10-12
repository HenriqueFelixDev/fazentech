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

    return Card(
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        child: InkWell(
          onTap: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 60.0, color: primaryColor),
              Text(category, style: TextStyle(fontSize: 22.0, color: primaryColor))
            ]
          )
        ),
      ),
    );
  }
}