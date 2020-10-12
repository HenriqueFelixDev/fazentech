import 'package:fazentech/app/shared/components/custom_app_bar_widget.dart';
import 'package:fazentech/app/shared/components/form/custom_text_form_field_widget.dart';
import 'package:fazentech/app/shared/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreditCardDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleText: 'Dados do Cartão'
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check, size: 24.0, color: Colors.white),
        onPressed: () => Modular.to.pushNamed('/checkout/confirmation'),
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
          Container(
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
                    child: Text('${index}x R\$${(21.99 / index).toStringAsFixed(2)}'),
                    value: index,
                  );
                }
              ), 
              onChanged: (value){}
            ),
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