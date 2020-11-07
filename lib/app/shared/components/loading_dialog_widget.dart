import 'package:flutter/material.dart';

class LoadingDialogWidget extends StatelessWidget {
  final String message;
  LoadingDialogWidget({
    Key key,
    this.message = 'Carregando'
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message),
          SizedBox(height: 8.0),
          CircularProgressIndicator()
        ]
      )
    );
  }
}