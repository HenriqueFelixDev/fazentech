import 'package:fazentech/app/modules/account/account_controller.dart';
import 'package:fazentech/app/modules/account/account_screen.dart';
import 'package:fazentech/app/shared/services/image_upload_firebase_storage.dart';
import 'package:fazentech/app/shared/services/image_upload_service_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AccountModule extends ChildModule {
  @override
  List<Bind> get binds => [
    Bind<IImageUploadService>((i) => ImageUploadFirebaseStorage()),
    Bind((i) => AccountController(i.get(), i.get()))
  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter('/', child: (_, args) => AccountScreen(args.data))
  ];
}