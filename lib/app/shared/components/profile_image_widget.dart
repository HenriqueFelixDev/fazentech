import 'package:flutter/cupertino.dart';
import 'package:octo_image/octo_image.dart';

class ProfileImageWidget extends StatelessWidget {
  final String profileImage;
  final double size;
  ProfileImageWidget({
    Key key,
    @required this.profileImage,
    this.size = 60.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OctoImage(
      width: size,
      height: size,
      fit: BoxFit.cover,
      imageBuilder: (_, image) => ClipOval(child: image),
      image: profileImage == null 
        ? AssetImage('assets/img/avatar.png')
        : NetworkImage(profileImage)
    );
  }
}