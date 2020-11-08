import 'dart:async';

import 'package:fazentech/app/modules/cart/cart_controller.dart';

import 'components/payment_method_card.dart';
import 'package:fazentech/app/shared/components/custom_app_bar_widget.dart';
import 'package:fazentech/app/shared/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PaymentMethodScreen extends StatefulWidget {
  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final controller = Modular.get<CartController>();
  StreamSubscription _cartSubscription;
  String value;

  @override
  void initState() {
    super.initState();
    _cartSubscription = controller.cart.listen((cart) {
      setState(() => value = cart.paymentMethod);
    });
  }

  @override
  void dispose() {
    _cartSubscription.cancel();
    super.dispose();
  }

  _onSelectValue(selectedValue) {
    controller.updateCart(paymentMethod: selectedValue);
    setState(() => value = selectedValue);
  }

  _goToNextPage() {
    value == 'credit_card'
      ? Modular.to.pushNamed('/cart/checkout/credit-card')
      : Modular.to.pushNamed('/cart/checkout/confirmation');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleText: 'Forma de Pagamento'
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check, size: 24.0, color: Colors.white),
        onPressed: _goToNextPage
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        children: [
          PaymentMethodCard(
            text: 'Cartão de Crédito',
            complement: Image.asset('assets/img/bandeiras-cartoes.png'),
            value: 'credit_card',
            groupValue: value,
            onSelect: _onSelectValue,
          ),
          PaymentMethodCard(
            text: 'Boleto Bancário',
            complement: Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.short_text)
            ),
            value: 'bank_slip',
            groupValue: value,
            onSelect: _onSelectValue,
          ),
        ]
      ),
    );
  }
}