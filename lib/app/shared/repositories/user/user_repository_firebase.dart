import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fazentech/app/shared/adapter/user/document_snapshot_user_adapter.dart';
import 'package:fazentech/app/shared/models/user/user_model.dart';
import 'package:fazentech/app/shared/repositories/auth/auth_repository_firebase.dart';
import 'package:fazentech/app/shared/repositories/auth/auth_repository_interface.dart';
import 'package:fazentech/app/shared/repositories/user/user_repository_interface.dart';

class UserRepositoryFirebase implements IUserRepository {
  FirebaseFirestore _firestore;
  UserRepositoryFirebase() {
    this._firestore = FirebaseFirestore.instance;
  }

  @override
  Future<UserModel> getUserById(String id) async{
    final documentSnapshot = 
      await _firestore
        .collection('users')
        .doc(id)
        .get();

    return DocumentSnapshotUserAdapter()
        .adaptDocumentSnapshotToModel(documentSnapshot);
  }

  @override
  Future<void> saveUser(UserModel user) async{
    final userMap = 
      DocumentSnapshotUserAdapter()
          .adaptModelToDocumentSnapshotData(user);

    await _firestore.collection('users').doc(user.id).set(userMap);
  }

  @override
  Future<void> updateUser(UserModel user) async{
    final userMap = 
      DocumentSnapshotUserAdapter()
          .adaptModelToDocumentSnapshotData(user);

    await _firestore.collection('users').doc(user.id).update(userMap);
  }

}