import 'package:fazentech/app/shared/models/product/category.dart';
import 'package:flutter_test/flutter_test.dart';

Category createCategory() {
  return Category(
    name: 'Frutas',
    description: 'Descrição',
    icon: 'frutas.jpg',
  );
}

Category createNullCategory() {
  return Category(
    name: null,
    description: null,
    icon: null,
  );
}

void main() {
  group('Teste de Instanciação do model Category', () {
    test('Construtor recebendo parâmetros null', () {
      final address = createNullCategory();

      expect(address, isA<Category>());
      expect(address.name, null);
      expect(address.description, null);
      expect(address.icon, null);
    });


    group('Category.fromMap', () {
      test('Product.fromMap retornando corretamente', () {
        expect(createCategory(), isA<Category>());
      });

      test('Category.fromMap recebendo null', () {
        expect(Category.fromMap(null), null);
      });

      test('Category.fromJson recebendo null', () {
        expect(Category.fromJson(null), null);
      });
    });
  });
}