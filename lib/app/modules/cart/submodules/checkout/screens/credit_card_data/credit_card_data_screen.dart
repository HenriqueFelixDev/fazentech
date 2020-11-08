import 'dart:async';

import 'package:fazentech/app/modules/cart/cart_controller.dart';
import 'package:fazentech/app/shared/components/custom_app_bar_widget.dart';
import 'package:fazentech/app/shared/components/form/custom_text_form_field_widget.dart';
import 'package:fazentech/app/shared/models/order/order.dart';
import 'package:fazentech/app/shared/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreditCardDataScreen extends StatefulWidget {
  @override
  _CreditCardDataScreenState createState() => _CreditCardDataScreenState();
}

class _CreditCardDataScreenState extends State<CreditCardDataScreen> {
  final controller = Modular.get<CartController>();
  int installmentCount = 1;
  double cartPrice = 0;

  @override
  void initState() {
    super.initState();
    controller.cart.last.then((cart) {
      updatePaymentInfo(cart.installmentCount, cart.total);
    });
  }

  void updatePaymentInfo(int installmentCount, double cartPrice) {
    setState(() {
      this.cartPrice = cartPrice;
      this.installmentCount = installmentCount;
    });    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleText: 'Dados do Cartão'
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check, size: 24.0, color: Colors.white),
        onPressed: () async{
          print(installmentCount);
          await controller.updateCart(installmentCount: installmentCount);
          Modular.to.pushNamed('/cart/checkout/confirmation');
        }
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        children: [
          SvgPicture.asset('assets/img/credit-card.svg', height: 200.0, fit: BoxFit.contain),
          SizedBox(height: 32.0),
          CustomTextFormField(
            label: 'Número',
          ),
          CustomTextFormField(
            label: 'CVV',
          ),
          Text('Parcelas'),
          SizedBox(height: 8.0),
          StreamBuilder<Order>(
            stream: controller.cart,
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.none || snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              final cart = snapshot.data;
              installmentCount = cart.installmentCount;
              cartPrice = cart.total;

              return Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder()
                  ),
                  value: 1,
                  items: List.generate(
                    12,
                    (index) {
                      index++;
                      return DropdownMenuItem(
                        child: Text('${index}x R\$${(cartPrice / index).toStringAsFixed(2)}'),
                        onTap: () {
                          controller.updateCart(installmentCount: index);
                        },
                        value: index,
                      );
                    }
                  ), 
                  onChanged: (value){}
                ),
              );
            }
          ),
          Text('Vencimento'),
          SizedBox(height: 8.0),
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  label: 'Mês',
                )
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: CustomTextFormField(
                  label: 'Ano',
                )
              )
            ],
          )
        ]
      ),
    );
  }
}