import 'package:fazentech/app/main_screen.dart';
import 'package:fazentech/app/modules/account/account_module.dart';
import 'package:fazentech/app/modules/auth/auth_module.dart';
import 'package:fazentech/app/modules/cart/cart_controller.dart';
import 'package:fazentech/app/modules/checkout/checkout_module.dart';
import 'package:fazentech/app/modules/order/order_module.dart';
import 'package:fazentech/app/modules/product/submodules/product/product_screen.dart';
import 'package:fazentech/app/modules/splash/splash_screen.dart';
import 'package:fazentech/app/shared/controllers/user_controller.dart';
import 'package:fazentech/app/shared/repositories/auth/auth_repository_firebase.dart';
import 'package:fazentech/app/shared/repositories/auth/auth_repository_interface.dart';
import 'package:fazentech/app/shared/repositories/order/order_repository_api.dart';
import 'package:fazentech/app/shared/repositories/order/order_repository_interface.dart';
import 'package:fazentech/app/shared/repositories/product/category_repository_api.dart';
import 'package:fazentech/app/shared/repositories/product/category_repository_interface.dart';
import 'package:fazentech/app/shared/repositories/product/product_repository_api.dart';
import 'package:fazentech/app/shared/repositories/product/product_repository_interface.dart';
import 'package:fazentech/app/shared/repositories/user/user_repository_api.dart';
import 'package:fazentech/app/shared/repositories/user/user_repository_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_widget.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
    Bind<IUserRepository>((i) => UserRepositoryAPI()),
    Bind<IAuthRepository>((i) => AuthRepositoryFirebase()),
    Bind<ICategoryRepository>((i) => CategoryRepositoryAPI()),
    Bind<IProductRepository>((i) => ProductRepositoryAPI(i.get())),
    Bind<IOrderRepository>((i) => OrderRepositoryAPI(i.get())),
    Bind((i) => CartController(i.get())),
    Bind((i) => UserController(i.get(), i.get()))
  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter('/', child: (_, __) => SplashScreen()),
    ModularRouter('/main', child: (_, __) => MainScreen()),
    ModularRouter('/auth', module: AuthModule()),
    ModularRouter('/produtos/:id', child: (_, args) => ProductScreen(product: args.data)),
    ModularRouter('/checkout', module: CheckoutModule()),
    ModularRouter('/account', module: AccountModule()),
    ModularRouter('/orders', module: OrderModule())
  ];

  @override
  Widget get bootstrap => AppWidget();
}