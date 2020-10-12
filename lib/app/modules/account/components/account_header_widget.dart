import 'package:flutter/material.dart';

class AccountHeaderWidget extends StatelessWidget {
  final ImageProvider profileImage;
  final String name;
  final String email;
  AccountHeaderWidget({
    Key key,
    @required this.name,
    @required this.email,
    @required this.profileImage
  }) : super(key: key);

  Widget _takePhotoButton() {
    return Container(
      alignment: Alignment.bottomRight,
      child: Material(
        shape: StadiumBorder(),
        color: Colors.black87,
        child: InkWell(
          onTap: (){},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.add_a_photo, size: 28.0, color: Colors.white)
          )
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ClipPath(
      clipper: _HeaderClipper(),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/account_header_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.white.withAlpha(150), BlendMode.luminosity)
          )
        ),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60.0,
              backgroundColor: Colors.grey[300],
              backgroundImage: profileImage,
              child: _takePhotoButton()
            ),
            SizedBox(height: 8.0),
            Text(name, style: textTheme.headline2),
            Text(email, style: TextStyle(color: Colors.white, shadows: [
              Shadow(
                color: Colors.black,
                offset: Offset(2.0, 2.0),
                blurRadius: 10.0
              )
            ]),)
          ],
        )
      )
    );
  }
}

class _HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(size.width / 2, size.height + 20, size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => this != oldClipper;
  
}