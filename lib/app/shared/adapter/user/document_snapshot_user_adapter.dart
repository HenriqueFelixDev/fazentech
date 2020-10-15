import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fazentech/app/shared/adapter/document_snapshot_model_adater_interface.dart';
import 'package:fazentech/app/shared/models/user/user_model.dart';

class DocumentSnapshotUserAdapter 
    implements IDocumentSnapshotModelAdapter<UserModel>{

  UserModel adaptDocumentSnapshotToModel(DocumentSnapshot documentSnapshot) {
    final userMap = documentSnapshot.data();
    userMap['id'] = documentSnapshot.id;
    userMap['birthday'] = userMap['birthday'].toDate().toString();
    return UserModel.fromMap(userMap);
  }

  Map<String, dynamic> adaptModelToDocumentSnapshotData(UserModel user) {
    final userMap = user.toMap();
    userMap.remove('id');
    userMap.remove('photo');
    userMap.remove('password');
    userMap['address'].remove('id');
    userMap['phone'].remove('id');
    userMap['cellphone'].remove('id');
    userMap['birthday'] = Timestamp.fromDate(user.birthday);

    return userMap;
  }
}