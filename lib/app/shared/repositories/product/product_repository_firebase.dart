import 'package:cloud_firestore/cloud_firestore.dart';

import 'category_repository_interface.dart';
import 'product_repository_interface.dart';
import '../../adapter/order/document_snapshot_order_product_adapter.dart';
import '../../adapter/product/document_snapshot_product_adapter.dart';
import '../../models/product/product_filter.dart';
import '../../models/product/product.dart';
import '../../models/order/order_product.dart';

class ProductRepositoryFirebase implements IProductRepository {
  FirebaseFirestore _firestore;
  ICategoryRepository categoryRepository;
  ProductRepositoryFirebase(this.categoryRepository) {
    _firestore = FirebaseFirestore.instance;
  }

  @override
  Future<void> addProductOnCart(OrderProduct orderProduct) async{
    final orderProductMap = DocumentSnapshotOrderProductAdapter()
        .adaptModelToDocumentSnapshotData(orderProduct);
    orderProductMap.remove('id');

    await _firestore.collection('users')
        .doc('G1HUt1Vh2l06Z51Kb8e6')
        .collection('cart')
        .add(orderProductMap);
  }

  @override
  Future<void> updateCartProduct(OrderProduct orderProduct) async{
    final orderProductMap = {
      'quantity': orderProduct.quantity
    };

    await _firestore.collection('users')
        .doc('G1HUt1Vh2l06Z51Kb8e6')
        .collection('cart')
        .doc(orderProduct.id)
        .update(orderProductMap);
  }

  @override
  Future<void> deleteCartProduct(String productId) async{
    await _firestore.collection('users')
        .doc('G1HUt1Vh2l06Z51Kb8e6')
        .collection('cart')
        .doc(productId)
        .delete();
  }

  @override
  Future<List<OrderProduct>> getOrderProducts(String orderId) async{
    final querySnapshot = await _firestore.collection('users')
        .doc('G1HUt1Vh2l06Z51Kb8e6')
        .collection('orders')
        .doc(orderId)
        .collection('products')
        .get();
    
    return await _getOrderProductListFromQuerySnapshot(querySnapshot);
  }

  @override
  Future<List<OrderProduct>> getCartProducts() async{
    final querySnapshot = await _firestore
        .collection('users')
        .doc('G1HUt1Vh2l06Z51Kb8e6')
        .collection('cart')
        .get();
    
    return await _getOrderProductListFromQuerySnapshot(querySnapshot);
  }

  @override
  Future<Product> getProductById(String id) async{
    final documentSnapshot = 
      await _firestore
          .collection('products')
          .doc(id)
          .get();

    return await _getProductFromDocumentSnapshot(documentSnapshot);
  }

  @override
  Future<List<Product>> getProducts(ProductFilter filter) async{
    final productsReference = _firestore.collection('products');

    Query productsQuery = productsReference;

    if(filter != null) {      
      if(filter.categories != null && filter.categories.isNotEmpty) {
        productsQuery = productsReference.where(
          'category', 
          whereIn: filter.categories
        );
      }

      // Descobrir uma forma de filtrar FullText no cloud firestore
      // if(filter.search != null && filter.search.isNotEmpty) {
      //   productsQuery = productsReference.orderBy('name').startAt([filter.search]).endAt([filter.search+'\uf8ff']);
      //   productsQuery = productsReference.where('description', isEqualTo: filter.search);
      // }
    }

    productsQuery = productsReference.where('price', isGreaterThanOrEqualTo: filter.minPrice ?? 0, isLessThanOrEqualTo: double.infinity);

    final querySnapshot = await productsQuery.get();
    final products = <Product>[];

    for(int i = 0; i < querySnapshot.docs.length; i++) {
      final product = await _getProductFromDocumentSnapshot(querySnapshot.docs[i]);
      products.add(product);
    }

    return products;
  }

  
  Future<List<Product>> getTopProducts() {

  }

  Future<List<Product>> getRecentlyAddedProducts() {

  }

  Future<Product> _getProductFromDocumentSnapshot(DocumentSnapshot documentSnapshot) async{
    final categoryId = documentSnapshot['category'].id;

    final product = 
      DocumentSnapshotProductAdapter()
          .adaptDocumentSnapshotToModel(documentSnapshot);

    product.category = await categoryRepository.getCategoryById(categoryId);

    return product;
  }

  Future<OrderProduct> _getOrderProductFromDocumentSnapshot(DocumentSnapshot documentSnapshot) async{
    final productId = documentSnapshot.data()['product'].id;
    final orderProduct = DocumentSnapshotOrderProductAdapter()
        .adaptDocumentSnapshotToModel(documentSnapshot);
    orderProduct.product = await getProductById(productId);

    return orderProduct;
  }

  Future<List<OrderProduct>> _getOrderProductListFromQuerySnapshot(QuerySnapshot querySnapshot) async{
    List<OrderProduct> orderProducts = [];

    for(int i = 0; i < querySnapshot.docs.length; i++) {
      final orderProduct = await _getOrderProductFromDocumentSnapshot(querySnapshot.docs[i]);
      orderProducts.add(orderProduct);
    }

    return orderProducts;
  }
}