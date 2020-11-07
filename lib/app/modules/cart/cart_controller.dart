import 'package:fazentech/app/shared/models/order/order.dart';
import 'package:fazentech/app/shared/models/order/order_product.dart';
import 'package:fazentech/app/shared/models/order/shipping.dart';
import 'package:fazentech/app/shared/models/product/product.dart';
import 'package:fazentech/app/shared/repositories/order/order_repository_interface.dart';
import 'package:fazentech/app/shared/repositories/order/shipping_repository_correios.dart';
import 'package:fazentech/app/shared/repositories/order/shipping_repository_interface.dart';
import 'package:rxdart/rxdart.dart';

class CartController {
  final IOrderRepository _orderRepository;
  final IShippingRepository _shippingRepository = ShippingRepositoryCorreios();
  CartController(this._orderRepository);

  Shipping _selectedShipping;
  final _selectedShippingSubject = BehaviorSubject<Shipping>();
  Stream<Shipping> get selectedShipping => _selectedShippingSubject.stream;

  List<Shipping> _shippings = [];
  final _shippingsSubject = BehaviorSubject<List<Shipping>>();
  Stream<List<Shipping>> get shippings => _shippingsSubject.stream;

  Order _cart;
  List<OrderProduct> _cartProducts = [];
  final _cartSubject = BehaviorSubject<Order>();
  Stream<Order> get cart => _cartSubject.stream;

  void selectShipping(Shipping shipping) {
    _selectedShipping = shipping;
    _selectedShippingSubject.sink.add(_selectedShipping);
  }

  Future<void> searchShippings() async {
    final shippings = await _shippingRepository.getShippings('36460000');
    _updateShippings(shippings);
    if(_selectedShipping == null) {
      selectShipping(shippings[0]);
    }
  }

  void _updateShippings(List<Shipping> shippings) {
    _shippings = shippings;
    _shippingsSubject.sink.add(_shippings);
  }

  Future<void> searchCart() async {
    final cart = await _orderRepository.getCart();
    _updateCart(cart);
  }

  Future<void> insertProductOnCart(Product product, int quantity) async{
    try {
      await _orderRepository.insertProductOnCart(product, quantity);
      _cartProducts.add(OrderProduct(price: product.price, product: product, quantity: quantity));
      _updateCart(_cart.copyWith(products: _cartProducts));
    } catch(e) {
      print('ERRO: $e');
    }
  }

  Future<void> updateCartProduct(OrderProduct cartProduct) async{
    try {
      await _orderRepository.updateCartProduct(cartProduct);
      final productIndex = _cartProducts.indexWhere((element) => cartProduct.product.id == element.product.id);
      _cartProducts[productIndex] = cartProduct;
      _updateCart(_cart.copyWith(products: _cartProducts));
    } catch(e) {
      print('ERRO: $e');
    }
  }

  Future<void> deleteCartProduct(OrderProduct cartProduct) async{
    try {
      await _orderRepository.deleteCartProduct(cartProduct.product);
      _cartProducts.remove(cartProduct);
      _updateCart(_cart.copyWith(products: _cartProducts));
    } catch(e) {
      print('ERRO: $e');
    }
  }

  void _updateCart(Order cart) {
    _cart = cart;
    if(cart != null) {
      _cartProducts = cart.products;
      _cartSubject.sink.add(_cart);
    }
  }
}