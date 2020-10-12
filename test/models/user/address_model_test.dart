import 'package:fazentech/app/shared/models/user/address.dart';
import 'package:fazentech/app/shared/models/user/state.dart';
import 'package:flutter_test/flutter_test.dart';

Address createNullAddress() {
  return Address(
    id: null,
    street: null,
    number: null,
    city: null,
    state: null,
    postalCode: null,
    district: null,
    complement: null,
  );
}

Address createAddress() {
  return Address(
    id: 'asdf1561',
    street: 'Rua X',
    number: '40',
    city: 'Belo Horizonte',
    state: State.valueOf('MG'),
    postalCode: '36455000',
    district: 'Centro',
    complement: '',
  );
}

void main() {
  group('Teste de Instanciação do model Address', () {
    test('Construtor recebendo parâmetros null', () {
      final address = createNullAddress();

      expect(address, isA<Address>());
      expect(address.id, null);
      expect(address.street, null);
      expect(address.number, null);
      expect(address.city, null);
      expect(address.state, null);
      expect(address.postalCode, null);
      expect(address.district, null);
      expect(address.complement, null);
    });


    group('Address.fromMap', () {
      test('Address.fromMap retornando corretamente', () {
        expect(createAddress(), isA<Address>());
      });

      test('Address.fromMap recebendo null', () {
        expect(Address.fromMap(null), null);
      });

      test('Address.fromJson recebendo null', () {
        expect(Address.fromJson(null), null);
      });
    });
  });
}