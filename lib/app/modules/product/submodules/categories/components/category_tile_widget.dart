import 'package:cached_network_image/cached_network_image.dart';
import 'package:fazentech/app/shared/components/image_loading_placeholder_widget.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';

class CategoryTileWidget extends StatelessWidget {

  final String category;
  final String icon;
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
              OctoImage(
                width: 50.0,
                height: 50.0,
                image: CachedNetworkImageProvider(icon),
                errorBuilder: OctoError.icon(icon: Icons.info, color: Colors.red),
                placeholderBuilder: (_) => ImageLoadingPlaceholderWidget()
              ),
              Text(category, style: TextStyle(fontSize: 22.0, color: primaryColor))
            ]
          )
        ),
      ),
    );
  }
}