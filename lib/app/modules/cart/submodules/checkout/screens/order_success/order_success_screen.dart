import 'package:fazentech/app/shared/components/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderSuccessScreen extends StatefulWidget {
  @override
  _OrderSuccessScreenState createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  child: Text(
                    'Pedido realizado com sucesso!',
                    textAlign: TextAlign.center, 
                    style: textTheme.headline2
                  )
                ),
                SvgPicture.asset('assets/img/checkout-confirmation.svg', height: 200.0, fit: BoxFit.contain),
                Text(
                  'Seu pedido está sendo preparado para ser enviado. Após a preparação ele será enviado, portanto, fique atento à situação deste pedido na página de pedidos.',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyText1
                ),
                SizedBox(height: 16.0),
                FlatButton(
                  child: Text('OK', style: TextStyle(fontSize: 22.0, color: Theme.of(context).accentColor)),
                  onPressed: () => Modular.to.popUntil(ModalRoute.withName('/main')),
                )
              ],
            ),
          ),
      )
    );
  }
}