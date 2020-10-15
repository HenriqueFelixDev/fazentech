
import 'package:fazentech/app/shared/models/user/phone.dart';
import 'package:fazentech/app/shared/models/user/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

UserModel createNullUser() {
  return UserModel(
    id: null,
    name: null,
    email: null,
    cpf: null,
    rg: null,
    password: null,
    phone: null,
    cellphone: null,
    birthday: null,
  );
}

UserModel createUser() {
  return UserModel(
    id: 'a51d',
    name: 'João',
    email: 'joao@mail.com',
    cpf: '000.000.000-00',
    rg: '00.000-0',
    password: 'abcd1234',
    phone: Phone(areaCode: '11', number: '12345678'),
    cellphone: Phone(areaCode: '11', number: '945671238'),
    birthday: DateTime.now(),
  );
}

void main() {
  group('Teste de Instanciação do model User', () {
    test('Construtor recebendo parâmetros null', () {
      final user = createNullUser();

      expect(user, isA<UserModel>());
      expect(user.id, null);
      expect(user.name, null);
      expect(user.email, null);
      expect(user.cpf, null);
      expect(user.rg, null);
      expect(user.password, null);
      expect(user.phone, null);
      expect(user.cellphone, null);
      expect(user.birthday, null);
    });


    group('User.fromMap', () {
      test('User.fromMap retornando corretamente', () {
        expect(createUser(), isA<UserModel>());
      });

      test('User.fromMap recebendo null', () {
        expect(UserModel.fromMap(null), null);
      });

      test('User.fromJson recebendo null', () {
        expect(UserModel.fromJson(null), null);
      });
    });
  });
}