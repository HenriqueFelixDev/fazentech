import 'package:fazentech/app/shared/models/user/state.dart';
import 'package:flutter_test/flutter_test.dart';

State createNullState() {
  return State.valueOf(null);
}

State createState() {
  return State.valueOf('MG');
}

void main() {
  group('Teste de Instanciação do model State', () {
    group('State.valueOf', () {
      test('State.valueOf recebendo parâmetros null', () {
        expect(createNullState(), null);
      });
      test('State.valueOf retornando corretamente', () {
        expect(createState(), isA<State>());
      });

      test('State.valueOf recebendo valor inexistente', () {
        expect(() => State.valueOf('AB'), throwsA(isArgumentError));
      });

      test('State.values retornando 27 valores', () {
        expect(State.values.toList().length, 27);
      });
    });
  });
}