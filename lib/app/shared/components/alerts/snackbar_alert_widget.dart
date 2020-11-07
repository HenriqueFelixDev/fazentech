import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum AlertType {
  ERROR, INFO, SUCCESS, WARNING, DEFAULT
}


IconData _getIcon(AlertType type) {
  switch(type) {
    case AlertType.SUCCESS:
      return FontAwesomeIcons.solidCheckCircle;
      
    case AlertType.ERROR:
      return FontAwesomeIcons.timesCircle;

    case AlertType.WARNING:
      return FontAwesomeIcons.exclamationTriangle;

    case AlertType.INFO:
      return FontAwesomeIcons.exclamationCircle;

    default:
      return null;
  }
}

Color _getMainColor(AlertType type) {
  switch(type) {
    case AlertType.SUCCESS:
      return Colors.green;
      
    case AlertType.ERROR:
      return Colors.red;

    case AlertType.WARNING:
      return Colors.yellow[800];

    case AlertType.INFO:
      return Colors.blue;

    default:
      return Colors.white;
  }
}

class SnackbarAlertWidget extends SnackBar {
    final String message;
    final AlertType type;
    final Duration duration;
    final SnackBarAction action;
    
    SnackbarAlertWidget({
      Key key,
      @required this.message,
      @required this.type,
      this.duration = const Duration(seconds: 5),
      this.action
    }) : super(
      key: key, 
      backgroundColor: _getMainColor(type),
      content: Row(
        children: [
          if(_getIcon(type) != null) Icon(_getIcon(type)),
          SizedBox(width: 8.0),
          Text(
            message, 
            style: TextStyle(
              color: type == AlertType.DEFAULT 
                ? Colors.black 
                : Colors.white
            )
          )
        ]
      ),
      duration: duration,
      shape: StadiumBorder(),
      behavior: SnackBarBehavior.floating,
      action: action
    );
}