import 'package:fazentech/app/shared/models/order/order_filter.dart';
import 'package:fazentech/app/shared/models/order/order_status.dart';
import 'package:flutter_test/flutter_test.dart';

OrderFilter createOrderFilter() {
  return OrderFilter(
    status: [
      OrderStatus.arrivedAtDestination
    ],
    minPrice: 0.0,
    maxPrice: 10.0,
    minDate: DateTime(2020, 10, 10),
    maxDate: DateTime.now(),
  );
}

OrderFilter createNullOrderFilter() {
  return OrderFilter(
    status: null,
    minPrice: null,
    maxPrice: null,
    minDate: null,
    maxDate: null
  );
}

void main() {
  group('Teste de Instanciação do model OrderFilter', () {
    test('Construtor recebendo parâmetros null', () {
      final orderFilter = createNullOrderFilter();

      expect(orderFilter, isA<OrderFilter>());
      expect(orderFilter.status, null);
      expect(orderFilter.minDate, null);
      expect(orderFilter.maxDate, null);
      expect(orderFilter.minPrice, null);
      expect(orderFilter.maxPrice, null);
    });


    group('OrderFilter.fromMap', () {
      test('OrderFilter.fromMap retornando corretamente', () {
        expect(createOrderFilter(), isA<OrderFilter>());
        expect(createOrderFilter().minDate, isA<DateTime>());
        expect(createOrderFilter().maxDate, isA<DateTime>());
      });

      test('OrderFilter.fromMap recebendo null', () {
        expect(OrderFilter.fromMap(null), null);
      });

      test('OrderFilter.fromJson recebendo null', () {
        expect(OrderFilter.fromJson(null), null);
      });
    });
  });
}