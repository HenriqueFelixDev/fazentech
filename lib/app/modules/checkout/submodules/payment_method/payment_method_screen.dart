import 'package:fazentech/app/modules/checkout/submodules/payment_method/components/payment_method_card.dart';
import 'package:fazentech/app/shared/components/custom_app_bar_widget.dart';
import 'package:fazentech/app/shared/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PaymentMethodScreen extends StatefulWidget {
  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String value = 'cartao_credito';

  _onSelectValue(selectedValue) => setState(() => value = selectedValue);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: Text('Forma de Pagamento', style: TextStylesSet.appBarTitleStyle)
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check, size: 24.0, color: Colors.white),
        onPressed: () => Modular.to.pushNamed('/checkout/credit-card')
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        children: [
          PaymentMethodCard(
            text: 'Cartão de Crédito',
            complement: Image.asset('assets/img/bandeiras-cartoes.png'),
            value: 'cartao_credito',
            groupValue: value,
            onSelect: _onSelectValue,
          ),
          PaymentMethodCard(
            text: 'Boleto Bancário',
            complement: Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.short_text)
            ),
            value: 'boleto_bancario',
            groupValue: value,
            onSelect: _onSelectValue,
          ),
        ]
      ),
    );
  }
}