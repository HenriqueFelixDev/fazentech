import 'package:fazentech/app/shared/models/product/product.dart';
import 'package:fazentech/app/shared/repositories/product/product_repository_interface.dart';
import 'package:rxdart/rxdart.dart';

class HomeController {
  IProductRepository productRepository;
  HomeController(this.productRepository);

  List<Product> _recentlyAddedProducts = [];
  final _recentlyAddedProductsSubject = BehaviorSubject<List<Product>>.seeded([]);
  Stream<List<Product>> get recentlyAddedProducts => _recentlyAddedProductsSubject.stream;

  List<Product> _topProducts = [];
  final _topProductsSubject = BehaviorSubject<List<Product>>.seeded([]);
  Stream<List<Product>> get topProducts => _topProductsSubject.stream;

  
  Future<Null> searchTopProducts() async {
    try {
      final products = await productRepository.getTopProducts();
      _updateTopProducts(products);
    } catch(e) {
      print('ERROR: $e');
    }
  }

  void _updateTopProducts(List<Product> products) {
    _topProducts = products;
    _topProductsSubject.sink.add(_topProducts);
  }

  Future<Null> searchRecentlyAddedProducts() async {
    try {
      final products = await productRepository.getRecentlyAddedProducts();
      _updateProducts(products);
    } catch(e) {
      print('ERROR: $e');
    }
  }

  void _updateProducts(List<Product> products) {
    _recentlyAddedProducts = products;
    _recentlyAddedProductsSubject.sink.add(_recentlyAddedProducts);
  }
}