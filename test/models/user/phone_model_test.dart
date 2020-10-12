import 'package:fazentech/app/shared/models/user/phone.dart';
import 'package:flutter_test/flutter_test.dart';

Phone createPhone() {
  return Phone(
    id: '15sd',
    areaCode: '11',
    number: '912345648'
  );
}

Phone createNullPhone() {
  return Phone(
    id: null,
    areaCode: null,
    number: null
  );
}

void main() {
  group('Teste de Instanciação do model Phone', () {
    test('Construtor recebendo parâmetros null', () {
      final phone = createNullPhone();

      expect(phone, isA<Phone>());
      expect(phone.id, null);
      expect(phone.areaCode, null);
      expect(phone.number, null);
    });


    group('Phone.fromMap', () {
      test('Phone.fromMap retornando corretamente', () {
        expect(createPhone(), isA<Phone>());
      });

      test('Phone.fromMap recebendo null', () {
        expect(Phone.fromMap(null), null);
      });

      test('Phone.fromJson recebendo null', () {
        expect(Phone.fromJson(null), null);
      });
    });
  });
}