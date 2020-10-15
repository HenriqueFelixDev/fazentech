import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fazentech/app/shared/adapter/order/document_snapshot_order_product_adapter.dart';
import 'package:fazentech/app/shared/adapter/product/document_snapshot_product_adapter.dart';
import 'package:fazentech/app/shared/adapter/order/document_snapshot_order_adapter.dart';
import 'package:fazentech/app/shared/models/order/order_filter.dart';
import 'package:fazentech/app/shared/models/order/order.dart';
import 'package:fazentech/app/shared/models/order/order_product.dart';
import 'package:fazentech/app/shared/models/order/order_status.dart';
import 'package:fazentech/app/shared/repositories/order/order_repository_interface.dart';
import 'package:fazentech/app/shared/repositories/product/product_repository_firebase.dart';
import 'package:fazentech/app/shared/repositories/product/product_repository_interface.dart';

class OrderRepositoryFirebase implements IOrderRepository {
  FirebaseFirestore _firestore;
  IProductRepository productRepository;
  OrderRepositoryFirebase() {
    _firestore = FirebaseFirestore.instance;
    productRepository = ProductRepositoryFirebase();
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

  @override
  Future<void> saveOrder() async{
    await _firestore.runTransaction<bool>((transaction) async{
      final cartProducts = await productRepository.getCartProducts();
      if(cartProducts == null || cartProducts.isEmpty) {
        return false;
      }
      
      final order = Order(
        status: OrderStatus.completePurchase.name,
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

}