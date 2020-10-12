import 'package:fazentech/app/shared/models/product/category.dart';
import 'package:fazentech/app/shared/models/product/product_filter.dart';
import 'package:flutter_test/flutter_test.dart';

ProductFilter createProductFilter() {
  return ProductFilter(
    search: 'Pesquisar',
    minPrice: 5.49,
    maxPrice: 10.50,
    categories: [
      Category(name: 'Category1'),
      Category(name: 'Category2'),
      Category(name: 'Category3'),
    ]
  );
}

ProductFilter createNullProductFilter() {
  return ProductFilter(
    search: null,
    minPrice: null,
    maxPrice: null,
    categories: null
  );
}

void main() {
  group('Teste de Instanciação do model ProductFilter', () {
    test('Construtor recebendo parâmetros null', () {
      final productFilter = createNullProductFilter();

      expect(productFilter, isA<ProductFilter>());
      expect(productFilter.search, null);
      expect(productFilter.categories, null);
      expect(productFilter.minPrice, null);
      expect(productFilter.maxPrice, null);
    });


    group('ProductFilter.fromMap', () {
      test('ProductFilter.fromMap retornando corretamente', () {
        expect(createProductFilter(), isA<ProductFilter>());
      });

      test('ProductFilter.fromMap recebendo null', () {
        expect(ProductFilter.fromMap(null), null);
      });

      test('ProductFilter.fromJson recebendo null', () {
        expect(ProductFilter.fromJson(null), null);
      });
    });
  });
}