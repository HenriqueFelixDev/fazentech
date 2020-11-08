import 'package:fazentech/app/shared/components/gradient_card_widget.dart';
import 'package:fazentech/app/shared/models/order/order.dart';
import 'package:fazentech/app/shared/theme/colors.dart';
import 'package:fazentech/app/shared/util/date_format_util.dart';
import 'package:flutter/material.dart';

class OrderCardWidget extends StatelessWidget {
  final Color mainColor;
  final Order order;
  final Function onDetailsPressed;
  OrderCardWidget({
    Key key,
    this.mainColor,
    @required this.order,
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
              Text('#${order.id}', style: textTheme.headline3),
              SizedBox(width: 8.0),
              Icon(Icons.date_range, color: Colors.black54),
              Expanded(
                child: Text(DateFormatUtil.formatDate(order.createdIn), style: textTheme.headline5.copyWith(color: Colors.black54))
              ),
              Expanded(
                child: Text(
                  order.status.toString(),
                  textAlign: TextAlign.end, 
                  style: textTheme.headline5.copyWith(color: _mainColor)
                ),
              )
            ]
          ),
          Row(
            children: [
              Text(
                'R\$ ${order.total.toStringAsFixed(2)}', 
                style: textTheme.headline2.copyWith(color: _mainColor)
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Ver detalhes', style: textTheme.headline4.copyWith(color: ColorsSet.accentColor)),
                    onPressed: onDetailsPressed,
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