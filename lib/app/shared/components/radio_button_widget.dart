import 'package:flutter/material.dart';

class RadioButtonWidget<T> extends StatelessWidget {
  final String label;
  final T value;
  final T groupValue;
  final Function(T value) onChanged;
  RadioButtonWidget({
    Key key,
    @required this.label,
    @required this.value,
    @required this.groupValue,
    @required this.onChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<T>(
          value: value,
          onChanged: onChanged,
          groupValue: groupValue
        ),
        Text(label)
      ],
    );
  }
}