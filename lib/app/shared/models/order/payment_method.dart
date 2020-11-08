import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';

part 'payment_method.g.dart';

class PaymentMethod extends EnumClass {
  static const PaymentMethod credit_card = _$credit_card;
  static const PaymentMethod bank_slip = _$bank_slip;

  const PaymentMethod._(String name) : super(name);
  
  static BuiltSet<PaymentMethod> get values => _$values;
  static PaymentMethod valueOf(String name) => _$valueOf(name);

  @override
  String toString() {
    switch(name) {
      case 'credit_card':
        return 'Cartão de crédito';
        break;
      case 'bank_slip':
        return 'Boleto Bancário';
        break;
    }
  }
}