import 'package:cloud_firestore/cloud_firestore.dart';

import 'category_repository_interface.dart';
import '../../adapter/product/document_snapshot_category_adapter.dart';
import '../../models/product/category.dart';

class CategoryRepositoryFirebase implements ICategoryRepository {
  FirebaseFirestore _firestore;
  CategoryRepositoryFirebase() {
    _firestore = FirebaseFirestore.instance;
  }

  @override
  Future<List<Category>> getAllCategories() async{
    final querySnapshots = 
      await _firestore
          .collection('categories')
          .orderBy('name')
          .get();
    
    final categories = querySnapshots.docs.map(
      (documentSnapshot) =>
        DocumentSnapshotCategoryAdapter()
            .adaptDocumentSnapshotToModel(documentSnapshot)
    ).toList();

    return categories;
  }

  @override
  Future<Category> getCategoryById(String id) async{
    final categorySnapshot = 
      await _firestore
          .collection('categories')
          .doc(id)
          .get();

    final categoryMap = categorySnapshot.data();
    categoryMap['id'] = categorySnapshot.id;
    
    return Category.fromMap(categoryMap);
  }

}