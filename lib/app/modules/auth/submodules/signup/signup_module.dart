import 'package:fazentech/app/modules/auth/submodules/login/login_screen.dart';
import 'package:fazentech/app/modules/auth/submodules/signup/signup_address_screen.dart';
import 'package:fazentech/app/modules/auth/submodules/signup/signup_controller.dart';
import 'package:fazentech/app/modules/auth/submodules/signup/sigup_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignUpModule extends ChildModule {
  @override
  List<Bind> get binds => [
    Bind((i) => SignupController())
  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter('/', child: (_, __) => SignUpScreen()),
    ModularRouter('/address', child: (_, __) => SignUpAddressScreen()),
  ];

}