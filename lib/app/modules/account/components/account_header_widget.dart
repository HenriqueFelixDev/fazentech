import 'package:fazentech/app/shared/components/profile_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AccountHeaderWidget extends StatelessWidget {

  final String profileImage;
  final String name;
  final String email;
  final Function(ImageSource) onChangeProfilePhotoPressed;
  AccountHeaderWidget({
    Key key,
    @required this.name,
    @required this.email,
    @required this.profileImage,
    @required this.onChangeProfilePhotoPressed
  }) : super(key: key);

  Widget _takePhotoButton(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      child: Material(
        shape: StadiumBorder(),
        color: Colors.black87,
        child: InkWell(
          onTap: () => _showImagePickerSourceOptions(context),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.add_a_photo, size: 28.0, color: Colors.white)
          )
        ),
      ),
    );
  }

  Widget _bottomSheetOption(BuildContext context, IconData icon, ImageSource source) {
    return Material(
      color: Theme.of(context).primaryColor,
      elevation: 8.0,
      borderRadius: BorderRadius.circular(10.0),
      child: InkWell(
        onTap: () => onChangeProfilePhotoPressed(source),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Icon(icon, color: Colors.white, size: 32.0)
        ),
      ),
    );
  }

  void _showImagePickerSourceOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheet(
          onClosing: (){},
          enableDrag: false,
          builder: (_) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Origem da imagem', style: Theme.of(context).textTheme.headline3),
                  SizedBox(height: 16.0),
                  Wrap(
                    spacing: 16.0,
                    children: [
                      _bottomSheetOption(
                        context, 
                        Icons.camera_alt, 
                        ImageSource.camera
                      ),
                      _bottomSheetOption(
                        context, 
                        Icons.photo_library, 
                        ImageSource.gallery
                      )
                    ]
                  )
                ],
              )
            );
          },
        );
      }
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
            colorFilter: ColorFilter.mode(Colors.black.withAlpha(50), BlendMode.luminosity)
          )
        ),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              child: Stack(
                children: [
                  Container(
                    child: ProfileImageWidget(
                      profileImage: profileImage,
                      size: 120.0
                    )
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: _takePhotoButton(context)
                  )
                ],
              )
            ),
            SizedBox(height: 8.0),
            Text(name, style: textTheme.headline2.copyWith(color: Colors.white)),
            Text(email, style: TextStyle(color: Colors.grey[100], shadows: [
              Shadow(
                color: Colors.black,
                offset: Offset(0.0, 0.0),
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