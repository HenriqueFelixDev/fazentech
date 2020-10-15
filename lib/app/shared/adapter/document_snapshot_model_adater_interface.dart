import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IDocumentSnapshotModelAdapter<T> {
  Map<String, dynamic> adaptModelToDocumentSnapshotData(T model);
  T adaptDocumentSnapshotToModel(DocumentSnapshot documentSnapshot);
}