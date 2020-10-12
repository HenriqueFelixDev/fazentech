import 'package:fazentech/app/shared/models/order/shipping.dart';
import 'package:flutter_test/flutter_test.dart';

Shipping createShipping() {
  return Shipping(
    type: 'PAC',
    value: 5.49,
    postalCode: '12345000',
    arrivalForecast: DateTime.now(),
  );
}

Shipping createNullShipping() {
  return Shipping(
    type: null,
    value: null,
    postalCode: null,
    arrivalForecast: null,
  );
}

void main() {
  group('Teste de Instanciação do model Shipping', () {
    test('Construtor recebendo parâmetros null', () {
      final shipping = createNullShipping();

      expect(shipping, isA<Shipping>());
      expect(shipping.type, null);
      expect(shipping.value, null);
      expect(shipping.postalCode, null);
      expect(shipping.arrivalForecast, null);
    });


    group('Shipping.fromMap', () {
      test('Shipping.fromMap retornando corretamente', () {
        expect(createShipping(), isA<Shipping>());
      });

      test('Shipping.fromMap recebendo null', () {
        expect(Shipping.fromMap(null), null);
      });

      test('Shipping.fromJson recebendo null', () {
        expect(Shipping.fromJson(null), null);
      });
    });
  });
}