import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';

part 'order_status.g.dart';

class OrderStatus extends EnumClass {
  static const OrderStatus buying = _$buying;
  static const OrderStatus completePurchase = _$completePurchase;
  static const OrderStatus preparingForShipment = _$preparingForShipment;
  static const OrderStatus sent = _$sent;
  static const OrderStatus arrivedAtDestination = _$arrivedAtDestination;

  const OrderStatus._(String name) : super(name);

  static BuiltSet<OrderStatus> get values => _$values;
  static OrderStatus valueOf(String name) =>
    name == null
      ? null
      : _$valueOf(name.toLowerCase());
}