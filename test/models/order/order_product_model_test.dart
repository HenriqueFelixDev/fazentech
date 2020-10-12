import 'package:fazentech/app/shared/models/order/order_product.dart';
import 'package:fazentech/app/shared/models/product/product.dart';
import 'package:flutter_test/flutter_test.dart';

OrderProduct createOrderProduct() {
  return OrderProduct(
    product: Product(),
    quantity: 2,
    createdIn: DateTime.now(),
    price: 5.49,
  );
}

OrderProduct createNullOrderProduct() {
  return OrderProduct(
    product: null,
    quantity: null,
    createdIn: null,
    price: null
  );
}

void main() {
  group('Teste de Instanciação do model OrderProduct', () {
    test('Construtor recebendo parâmetros null', () {
      final orderProduct = createNullOrderProduct();

      expect(orderProduct, isA<OrderProduct>());
      expect(orderProduct.product, null);
      expect(orderProduct.quantity, null);
      expect(orderProduct.createdIn, null);
      expect(orderProduct.price, null);
    });


    group('OrderProduct.fromMap', () {
      test('OrderProduct.fromMap retornando corretamente', () {
        expect(createOrderProduct(), isA<OrderProduct>());
      });

      test('OrderProduct.fromMap recebendo null', () {
        expect(OrderProduct.fromMap(null), null);
      });

      test('OrderProduct.fromJson recebendo null', () {
        expect(OrderProduct.fromJson(null), null);
      });
    });
  });
}