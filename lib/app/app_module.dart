import 'package:fazentech/app/main_screen.dart';
import 'package:fazentech/app/modules/account/account_module.dart';
import 'package:fazentech/app/modules/auth/auth_module.dart';
import 'package:fazentech/app/modules/checkout/screens/credit_card_data/credit_card_data_screen.dart';
import 'package:fazentech/app/modules/checkout/screens/order_success/order_success_screen.dart';
import 'package:fazentech/app/modules/checkout/screens/payment_method/payment_method_screen.dart';
import 'package:fazentech/app/modules/order/screens/order_details/order_details_screen.dart';
import 'package:fazentech/app/modules/order/screens/order_finish/order_finish_screen.dart';
import 'package:fazentech/app/modules/order/screens/orders/orders_screen.dart';
import 'package:fazentech/app/modules/product/product_controller.dart';
import 'package:fazentech/app/modules/product/submodules/product/product_screen.dart';
import 'package:fazentech/app/modules/product/submodules/products/products_screen.dart';
import 'package:fazentech/app/modules/splash/splash_screen.dart';
import 'package:fazentech/app/shared/controllers/user_controller.dart';
import 'package:fazentech/app/shared/repositories/auth/auth_repository_firebase.dart';
import 'package:fazentech/app/shared/repositories/auth/auth_repository_interface.dart';
import 'package:fazentech/app/shared/repositories/product/category_repository_firebase.dart';
import 'package:fazentech/app/shared/repositories/product/category_repository_interface.dart';
import 'package:fazentech/app/shared/repositories/product/product_repository_firebase.dart';
import 'package:fazentech/app/shared/repositories/product/product_repository_interface.dart';
import 'package:fazentech/app/shared/repositories/user/user_repository_firebase.dart';
import 'package:fazentech/app/shared/repositories/user/user_repository_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_widget.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
    Bind<IProductRepository>((i) => ProductRepositoryFirebase()),
    Bind<IAuthRepository>((i) => AuthRepositoryFirebase(i.get())),
    Bind<IUserRepository>((i) => UserRepositoryFirebase()),
    Bind<ICategoryRepository>((i) => CategoryRepositoryFirebase()),
    Bind((i) => UserController(i.get(), i.get())),
    Bind((i) => ProductController(i.get(), i.get()))
  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter('/', child: (_, __) => SplashScreen()),
    ModularRouter('/main', child: (_, __) => MainScreen()),
    ModularRouter('/auth', module: AuthModule()),
    ModularRouter('/products', child: (_, __) => ProductsScreen()),
    ModularRouter('/products/:id', child: (_, args) => ProductScreen(product: args.data)),
    ModularRouter('/checkout/methods', child: (_, __) => PaymentMethodScreen()),
    ModularRouter('/checkout/credit-card', child: (_, __) => CreditCardDataScreen()),
    ModularRouter('/checkout/confirmation', child: (_, __) => OrderFinishScreen()),
    ModularRouter('/checkout/success', child: (_, __) => OrderSuccessScreen()),
    ModularRouter('/account', module: AccountModule()),
    ModularRouter('/orders', child: (_, __) => OrdersScreen()),
    ModularRouter('/orders/:id', child: (_, __) => OrderDetailsScreen()),
  ];

  @override
  Widget get bootstrap => AppWidget();
}