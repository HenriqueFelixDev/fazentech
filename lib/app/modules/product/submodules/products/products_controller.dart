import 'dart:async';

import 'package:fazentech/app/shared/models/product/product.dart';
import 'package:fazentech/app/shared/models/product/product_filter.dart';
import 'package:fazentech/app/shared/repositories/product/product_repository_interface.dart';
import 'package:rxdart/rxdart.dart';

class ProductsController {
  IProductRepository productRepository;
  ProductsController(this.productRepository) {
    _filterSubscription = _filterSubject.stream.listen(
      (filter) {
        searchProducts(filter: filter);
      }
    );
  }

  List<Product> _products = [];
  final _productsSubject = BehaviorSubject<List<Product>>.seeded([]);
  Stream<List<Product>> get products => _productsSubject.stream;

  final _filterSubject = StreamController<ProductFilter>();
  Sink<ProductFilter> get filter => _filterSubject.sink;
  StreamSubscription<ProductFilter> _filterSubscription;

  
  Future<Null> searchProducts({ProductFilter filter}) async {
    try {
      final products = await productRepository.getProducts(filter);
      _updateProducts(products);
    } catch(e) {
      print('ERROR: $e');
    }
  }

  void _updateProducts(List<Product> products) {
    _products = products;
    _productsSubject.sink.add(_products);
  }
}