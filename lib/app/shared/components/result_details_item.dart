import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class ResultDetailsItem extends StatelessWidget {
  final String label;
  final String value;
  ResultDetailsItem({
    Key key,
    this.label,
    this.value
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(label),
          Expanded(
            child: Container(
              child: DottedLine(
                dashGapLength: 1.0,
                dashColor: Colors.grey[400],
              ),
            )
          ),
          Text(value, style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}