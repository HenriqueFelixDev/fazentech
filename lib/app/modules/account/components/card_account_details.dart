import 'package:fazentech/app/shared/components/custom_card_widget.dart';
import 'package:flutter/material.dart';

class CardAccountDetails extends StatelessWidget {
  final String title;
  final Map<String, String> accountData;
  final Function onEditPressed;
  CardAccountDetails({
    Key key,
    @required this.title,
    @required this.accountData,
    @required this.onEditPressed
  }) : super(key: key);

  List<Widget> _getAccountDataWidgets() {
    return accountData.keys.map(
      (accountDataLabel) => 
        Container(
          margin: const EdgeInsets.only(bottom: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(accountDataLabel, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(accountData[accountDataLabel], maxLines: 5, overflow: TextOverflow.ellipsis)
            ],
          ),
        )
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CustomCardWidget(
      margin: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: textTheme.headline3),
              SizedBox(width: 4.0),
              RaisedButton.icon(
                shape: StadiumBorder(),
                icon: Icon(Icons.edit, size: 16.0),
                label: Text('Editar', style: textTheme.subtitle1),
                onPressed: onEditPressed,
              )
            ],
          ),
          SizedBox(height: 8.0),
          ..._getAccountDataWidgets()
        ],
      )
    );
  }
}