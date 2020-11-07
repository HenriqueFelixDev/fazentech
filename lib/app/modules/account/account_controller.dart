import 'dart:io';

import 'package:fazentech/app/shared/controllers/user_controller.dart';
import 'package:fazentech/app/shared/controllers/user_store.dart';
import 'package:fazentech/app/shared/models/user/user_model.dart';
import 'package:fazentech/app/shared/services/image_upload_service_interface.dart';
import 'package:image_picker/image_picker.dart';

class AccountController {
  UserStore _userController;
  IImageUploadService _imageUploadService;
  ImagePicker _imagePicker;

  AccountController(
    this._userController, 
    this._imageUploadService
  ) : _imagePicker = ImagePicker();

  Future<String> pickImage(
    ImageSource source,
    bool Function(double) onProgress,
    void Function(String) onSuccess,
    void Function(dynamic) onError
  ) async{
    final pickedFile = 
      await _imagePicker
        .getImage(source: source, preferredCameraDevice: CameraDevice.front);

    if(pickedFile == null) return null;

    String imageUrl;

    final imageFile = File(pickedFile.path);
    await _imageUploadService.uploadImage(
      imageFile,
      onProgress: onProgress,
      onSucess: onSuccess,
      onError: onError
    );

    return imageUrl;
  }

  Future<void> updateAccount(UserModel user) async{
    await _userController.updateUser(user);
  }

}