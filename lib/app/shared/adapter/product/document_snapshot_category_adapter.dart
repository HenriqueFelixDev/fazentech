import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fazentech/app/shared/adapter/document_snapshot_model_adater_interface.dart';
import 'package:fazentech/app/shared/models/product/category.dart';

class DocumentSnapshotCategoryAdapter 
    implements IDocumentSnapshotModelAdapter<Category>{

  Category adaptDocumentSnapshotToModel(DocumentSnapshot documentSnapshot) {
    final categoryMap = documentSnapshot.data();
    categoryMap['id'] = documentSnapshot.id;
    return Category.fromMap(categoryMap);
  }

  @override
  Map<String, dynamic> adaptModelToDocumentSnapshotData(Category model) {
    throw UnimplementedError();
  }
  
}