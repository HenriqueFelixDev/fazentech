import 'package:fazentech/app/shared/models/order/Order.dart';
import 'package:fazentech/app/shared/models/order/order_product.dart';
import 'package:fazentech/app/shared/models/order/order_status.dart';
import 'package:flutter_test/flutter_test.dart';

Order createOrder() {
  return Order(
    id: 'sd15f3',
    products: [
      OrderProduct()
    ],
    createdIn: DateTime.now(),
    status: 'buying'
  );
}

Order createNullOrder() {
  return Order(
    id: null,
    products: null,
    createdIn: null,
    status: null
  );
}

void main() {
  group('Teste de Instanciação do model Order', () {
    test('Construtor recebendo parâmetros null', () {
      final order = createNullOrder();

      expect(order, isA<Order>());
      expect(order.id, null);
      expect(order.products, null);
      expect(order.createdIn, null);
      expect(order.status, null);
    });


    group('Order.fromMap', () {
      test('Order.fromMap retornando corretamente', () {
        expect(createOrder(), isA<Order>());
        expect(createOrder().status, isA<OrderStatus>());
        expect(createOrder().status, OrderStatus.buying);
      });

      test('Order.fromMap recebendo null', () {
        expect(Order.fromMap(null), null);
      });

      test('Order.fromJson recebendo null', () {
        expect(Order.fromJson(null), null);
      });
    });
  });
}