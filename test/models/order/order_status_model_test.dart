
import 'package:fazentech/app/shared/models/order/order_status.dart';
import 'package:flutter_test/flutter_test.dart';

OrderStatus createNullOrderStatus() {
  return OrderStatus.valueOf(null);
}

OrderStatus createOrderStatus() {
  return OrderStatus.valueOf('BUYING');
}

void main() {
  group('Teste de Instanciação do model OrderStatus', () {
    group('OrderStatus.valueOf', () {
      test('OrderStatus.valueOf recebendo parâmetros null', () {
        expect(createNullOrderStatus(), null);
      });
      test('OrderStatus.valueOf retornando corretamente', () {
        expect(createOrderStatus(), isA<OrderStatus>());
      });

      test('OrderStatus.valueOf recebendo valor inexistente', () {
        expect(() => OrderStatus.valueOf('AB'), throwsA(isArgumentError));
      });

      test('OrderStatus.values retornando 5 valores', () {
        expect(OrderStatus.values.toList().length, 5);
      });
    });
  });
}