import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';

part 'order_status.g.dart';

class OrderStatus extends EnumClass {
  static const OrderStatus buying = _$buying;
  static const OrderStatus complete_purchase = _$complete_purchase;
  static const OrderStatus preparing_for_shipment = _$preparing_for_shipment;
  static const OrderStatus sent = _$sent;
  static const OrderStatus arrived_at_destination = _$arrived_at_destination;

  const OrderStatus._(String name) : super(name);

  static BuiltSet<OrderStatus> get values => _$values;
  static OrderStatus valueOf(String name) => _$valueOf(name);

  @override
  String toString() {
    switch(name) {
      case 'buying':
        return 'Comprando';
        break;
      case 'complete_purchase':
        return 'Compra finalizada';
        break;
      case 'preparing_for_shipment':
        return 'Preparando para envio';
        break;
      case 'sent':
        return 'Enviado';
        break;
      case 'arrived_at_destination':
        return 'Chegou ao destino';
        break;
    }
  }
}