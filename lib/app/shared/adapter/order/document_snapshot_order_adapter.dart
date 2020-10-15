import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fazentech/app/shared/models/order/order.dart';

class DocumentSnapshotOrderAdapter {
  static Order adaptDocumentSnapshotToOrder(DocumentSnapshot documentSnapshot) {
    final orderMap = documentSnapshot.data();
    orderMap['id'] = documentSnapshot.id;
    orderMap.remove('products');
    orderMap['createdIn'] = orderMap['createdIn'].toDate().toString();
    return Order.fromMap(orderMap);
  }

  static Map<String, dynamic> adaptOrderToDocumentSnapshotData(Order order) {
    final orderMap = order.toMap();
    orderMap.remove('products');
    orderMap['createdIn'] = Timestamp.now();
    return orderMap;
  }
}