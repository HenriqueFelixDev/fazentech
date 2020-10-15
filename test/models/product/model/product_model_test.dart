import 'package:fazentech/app/shared/models/product/category.dart';
import 'package:fazentech/app/shared/models/product/product.dart';
import 'package:flutter_test/flutter_test.dart';

Product createNullProduct() {
  return Product(
    id: null,
    name: null,
    description: null,
    price: null,
    images: null,
    category: null,
  );
}

Product createProduct() {
  return Product(
    id: 'sd1f65',
    name: 'Abacaxi 1KG',
    description: 'Abacaxi de Marataíses',
    price: 5.49,
    images: [
      'img1.jpg',
      'img2.jpg',
      'img3.jpg',
    ],
    category: Category(
      icon: 'icon.jpg',
      name: 'Frutas',
      description: 'Descrição'
    ),
  );
}

void main() {
  group('Teste de Instanciação do model Product', () {
    test('Construtor recebendo parâmetros null', () {
      final address = createNullProduct();

      expect(address, isA<Product>());
      expect(address.id, null);
      expect(address.description, null);
      expect(address.name, null);
      expect(address.price, null);
      expect(address.images, null);
      expect(address.category, null);
    });


    group('Product.fromMap', () {
      test('Product.fromMap retornando corretamente', () {
        expect(createProduct(), isA<Product>());
      });

      test('Product.fromMap recebendo null', () {
        expect(Product.fromMap(null), null);
      });

      test('Product.fromJson recebendo null', () {
        expect(Product.fromJson(null), null);
      });
    });
  });
}