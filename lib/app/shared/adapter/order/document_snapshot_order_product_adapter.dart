import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fazentech/app/shared/models/order/order_product.dart';

import '../document_snapshot_model_adater_interface.dart';

class DocumentSnapshotOrderProductAdapter 
    implements IDocumentSnapshotModelAdapter<OrderProduct>{
  
  OrderProduct adaptDocumentSnapshotToModel(DocumentSnapshot documentSnapshot) {
    final orderProductMap = documentSnapshot.data();
    orderProductMap['id'] = documentSnapshot.id;
    orderProductMap['createdIn'] = documentSnapshot['createdIn']?.toDate()?.toString();

    orderProductMap.remove('product');
    return OrderProduct.fromMap(orderProductMap);
  }

  Map<String, dynamic> adaptModelToDocumentSnapshotData(OrderProduct orderProduct) {
    final orderProductMap = orderProduct.toMap();
    orderProductMap['createdIn'] = Timestamp.fromDate(orderProduct.createdIn);
    orderProductMap['product'] = FirebaseFirestore.instance.doc('products/' + orderProduct.product.id);
    return orderProductMap;
  }
}