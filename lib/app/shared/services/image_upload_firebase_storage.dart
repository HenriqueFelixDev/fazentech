import 'dart:io';

import 'package:fazentech/app/shared/services/image_upload_service_interface.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class ImageUploadFirebaseStorage implements IImageUploadService {
  FirebaseStorage _storage;
  ImageUploadFirebaseStorage(){
    _storage = FirebaseStorage.instance;
  }

  @override
  Future<void> uploadImage(File file, {onProgress, onCompleted, onSucess, onError, onCancel}) async{
    final storageReference = 
        _storage.ref()
          .child('users')
          .child('profiles').
          child('${Uuid().v1()}.jpg');

    final uploadTask = storageReference.putFile(file);

    uploadTask.events.listen((event) async{
      switch(event.type) {
        case StorageTaskEventType.progress:
          _onProgress(uploadTask, event.snapshot, onProgress);
          break;
          
        case StorageTaskEventType.failure:
          _onError(event.snapshot, onError);
          onCompleted?.call();
          break;
        
        case StorageTaskEventType.success:
          onSucess?.call(await event.snapshot.ref.getDownloadURL());
          onCompleted?.call();
          break;
      }
    });

    await uploadTask.onComplete;
  }

  void _onProgress(StorageUploadTask uploadTask, StorageTaskSnapshot snapshot, bool Function(double) onProgress) {
    double progress = _getUploadProgress(
      snapshot.totalByteCount, 
      snapshot.bytesTransferred
    );

    bool continueUpload = onProgress?.call(progress);
    if(continueUpload != null && !continueUpload) {
      uploadTask.cancel();
    }
  }

  void _onError(StorageTaskSnapshot snapshot, Function(dynamic) onError) {
    onError?.call('Falha ao enviar o(s) arquivo(s). ${snapshot.error}');
  }

  double _getUploadProgress(int totalBytesCount, int bytesTransferred) {
    return bytesTransferred / totalBytesCount;
  }
}