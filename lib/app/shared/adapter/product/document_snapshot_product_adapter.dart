import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fazentech/app/shared/adapter/document_snapshot_model_adater_interface.dart';
import 'package:fazentech/app/shared/models/product/product.dart';

class DocumentSnapshotProductAdapter 
    implements IDocumentSnapshotModelAdapter<Product>{

  Product adaptDocumentSnapshotToModel(DocumentSnapshot documentSnapshot) {
    final productMap = documentSnapshot.data();
    productMap['id'] = documentSnapshot.id;
    productMap.remove('category');
    return Product.fromMap(productMap);
  }

  Map<String, dynamic> adaptModelToDocumentSnapshotData(Product product){
    final productMap = product.toMap();
    productMap['category'] = 
      FirebaseFirestore.instance
          .doc('categories/' + product.category.id);

    return productMap;
  }
}