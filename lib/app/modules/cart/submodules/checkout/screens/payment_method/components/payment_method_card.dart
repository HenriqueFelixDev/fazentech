import 'package:flutter/material.dart';

class PaymentMethodCard extends StatelessWidget {
  String text;
  Widget complement;
  final String value;
  final String groupValue;
  final Function(String value) onSelect;
  PaymentMethodCard({
    Key key,
    @required this.text,
    @required this.value,
    @required this.groupValue,
    @required this.onSelect,
    this.complement
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => onSelect(value),
      child: Container(
        height: 80.0,
        child: Card(
          color: Colors.grey[200],
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Radio(
                  value: value,
                  groupValue: groupValue,
                  onChanged: onSelect
                ),
                Expanded(
                  child: Text(
                    text, 
                    maxLines: 3,
                    style: textTheme.headline4, 
                    overflow: TextOverflow.ellipsis
                  )
                ),
                if(complement != null) complement
              ],
            ),
          )
        ),
      )
    );
  }
}