import 'package:fazentech/app/shared/models/payment/credit_card.dart';
import 'package:flutter_test/flutter_test.dart';

CreditCard createCreditCard() {
  return CreditCard(
    cvv: '123',
    token: '1234567890123456',
    expiresOn: DateTime.now()
  );
}

CreditCard createNullCreditCard() {
  return CreditCard(
    cvv: null,
    token: null,
    expiresOn: null
  );
}

void main() {
  group('Teste de Instanciação do model CreditCard', () {
    test('Construtor recebendo parâmetros null', () {
      final creditCard = createNullCreditCard();

      expect(creditCard, isA<CreditCard>());
      expect(creditCard.cvv, null);
      expect(creditCard.token, null);
      expect(creditCard.expiresOn, null);
    });


    group('CreditCard.fromMap', () {
      test('CreditCard.fromMap retornando corretamente', () {
        expect(createCreditCard(), isA<CreditCard>());
        expect(createCreditCard().expiresOn, isA<DateTime>());
      });

      test('CreditCard.fromMap recebendo null', () {
        expect(CreditCard.fromMap(null), null);
      });

      test('CreditCard.fromJson recebendo null', () {
        expect(CreditCard.fromJson(null), null);
      });
    });
  });
}