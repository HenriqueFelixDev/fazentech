import 'package:fazentech/app/shared/components/gradient_card_widget.dart';
import 'package:fazentech/app/shared/theme/colors.dart';
import 'package:flutter/material.dart';

class OrderCardWidget extends StatelessWidget {
  final Color mainColor;
  final String orderId;
  final DateTime orderDate;
  final double orderPrice;
  final String orderStatus;
  final Function onDetailsPressed;
  OrderCardWidget({
    Key key,
    this.mainColor,
    @required this.orderId,
    @required this.orderDate,
    @required this.orderPrice,
    @required this.orderStatus,
    @required this.onDetailsPressed
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final _mainColor = mainColor ?? Theme.of(context).primaryColor;

    return GradientCardWidget(
      beginColor: _mainColor,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('#$orderId', style: textTheme.headline5.copyWith(fontWeight: FontWeight.bold)),
              SizedBox(width: 8.0),
              Icon(Icons.date_range, color: Colors.black54),
              Text(orderDate.toString(), style: textTheme.headline6.copyWith(color: Colors.black54)),
              Expanded(
                child: Text(
                  orderStatus, 
                  textAlign: TextAlign.end, 
                  style: textTheme.headline6.copyWith(color: _mainColor)
                ),
              )
            ]
          ),
          Row(
            children: [
              Text(
                'R\$ ${orderPrice.toStringAsFixed(2)}', 
                style: textTheme.headline4.copyWith(fontWeight: FontWeight.bold, color: _mainColor)
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Ver detalhes', style: textTheme.headline6.copyWith(color: ColorsSet.accentColor)),
                    onPressed: (){},
                  )
                )
              )
            ]
          )
        ]
      )
    );
  }
}