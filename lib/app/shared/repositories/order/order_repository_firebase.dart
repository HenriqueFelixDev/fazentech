import 'package:cloud_firestore/cloud_firestore.dart';

import 'order_repository_interface.dart';
import '../product/product_repository_interface.dart';
import '../../adapter/order/document_snapshot_order_product_adapter.dart';
import '../../adapter/order/document_snapshot_order_adapter.dart';
import '../../models/order/order_filter.dart';
import '../../models/order/order.dart';
import '../../models/order/order_product.dart';
import '../../models/order/order_status.dart';
import '../../models/product/product.dart';

class OrderRepositoryFirebase implements IOrderRepository {
  FirebaseFirestore _firestore;
  IProductRepository productRepository;
  OrderRepositoryFirebase(this.productRepository) {
    _firestore = FirebaseFirestore.instance;
  }

  @override
  Future<Order> getOrderById(String id) async{
    final documentSnapshot = 
      await _firestore
        .collection('users')
        .doc('G1HUt1Vh2l06Z51Kb8e6')
        .collection('orders')
        .doc(id)
        .get();
    
    return _getOrderFromDocumentSnapshot(documentSnapshot);
  }

  @override
  Future<List<Order>> getOrders(OrderFilter filter) async{
    final querySnapshot = 
      await _firestore
        .collection('users')
        .doc('G1HUt1Vh2l06Z51Kb8e6')
        .collection('orders')
        .get();
    
    List<Order> orders = [];

    for(int i = 0; i < querySnapshot.docs.length; i++) {
      final order = await _getOrderFromDocumentSnapshot(querySnapshot.docs[i]);
      orders.add(order);
    }

    return orders;
  }
  
  Future<Order> getCart() {
    return null;
  }

  @override
  Future<void> saveOrder() async{
    await _firestore.runTransaction<bool>((transaction) async{
      final cartProducts = await productRepository.getCartProducts();
      if(cartProducts == null || cartProducts.isEmpty) {
        return false;
      }
      
      final order = Order(
        status: OrderStatus.complete_purchase.name,
        createdIn: Timestamp.now().toDate()
      );

      final orderMap = 
        DocumentSnapshotOrderAdapter
            .adaptOrderToDocumentSnapshotData(order);
      orderMap.remove('id');
      
      final orderReference = 
        await _firestore
            .collection('users')
            .doc('G1HUt1Vh2l06Z51Kb8e6')
            .collection('orders')
            .add(orderMap);

      _addProductsOnOrder(orderReference, transaction, cartProducts);
      await _deleteCartProducts(transaction);
      return true;
    });
  }

  void _addProductsOnOrder(
    DocumentReference orderReference, 
    Transaction transaction, 
    List<OrderProduct> orderProducts
  ) {

    for(var cartProduct in orderProducts) {
      final cartProductMap = 
        DocumentSnapshotOrderProductAdapter()
            .adaptModelToDocumentSnapshotData(cartProduct);
        
      transaction.set(orderReference.collection('products').doc(), cartProductMap);
    }
  }

  Future<void> _deleteCartProducts(Transaction transaction) async{
    final querySnapshot = await _firestore
      .collection('users')
      .doc('G1HUt1Vh2l06Z51Kb8e6')
      .collection('cart')
      .get();
    
    for(int i = 0; i < querySnapshot.docs.length; i++) {
      transaction.delete(querySnapshot.docs[i].reference);
    }
  }

  @override
  Future<void> updateOrder(Order order) async{
    final orderMap = {
      'status': order.status.name
    };

    await _firestore
        .collection('users')
        .doc('G1HUt1Vh2l06Z51Kb8e6')
        .collection('orders')
        .doc(order.id)
        .update(orderMap);
  }

  Future<Order> _getOrderFromDocumentSnapshot(DocumentSnapshot documentSnapshot) async{
    final order = 
      DocumentSnapshotOrderAdapter
          .adaptDocumentSnapshotToOrder(documentSnapshot);
    
    order.products = await productRepository.getOrderProducts(order.id);

    return order;
  }

  @override
  Future<void> deleteCartProduct(Product product) {
      // TODO: implement deleteCartProduct
      throw UnimplementedError();
    }
  
    @override
    Future<void> insertProductOnCart(Product product, int quantity) {
      // TODO: implement insertProductOnCart
      throw UnimplementedError();
    }
  
    @override
    Future<void> updateCartProduct(OrderProduct cartProduct) {
    // TODO: implement updateCartProduct
    throw UnimplementedError();
  }

}