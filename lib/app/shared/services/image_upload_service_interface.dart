// Se o upload precisar ser cancelado, basta retornar false,
// caso contrário o upload continua
import 'dart:io';

typedef bool UploadProgressCallback(double progress);
typedef void UploadCompletedCallback();
typedef void UploadSuccessCallback(String url);
typedef void UploadErrorCallback(dynamic error);
typedef void UploadCancelCallback();

abstract class IImageUploadService{
  Future<void> uploadImage(File file, {
    UploadProgressCallback onProgress,
    UploadCompletedCallback onCompleted,
    UploadSuccessCallback onSucess,
    UploadErrorCallback onError,
    UploadCancelCallback onCancel
  });
}