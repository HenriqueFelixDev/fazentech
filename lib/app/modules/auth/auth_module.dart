import 'package:fazentech/app/modules/auth/submodules/login/login_screen.dart';
import 'package:fazentech/app/modules/auth/submodules/signup/signup_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends ChildModule {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRouter> get routers => [
    ModularRouter('/', child: (_, __) => LoginScreen()),
    ModularRouter('/signup', module: SignUpModule()),
  ];

}