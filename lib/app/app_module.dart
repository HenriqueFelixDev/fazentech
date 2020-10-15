import 'package:fazentech/app/main_screen.dart';
import 'package:fazentech/app/modules/account/account_module.dart';
import 'package:fazentech/app/modules/account/account_screen.dart';
import 'package:fazentech/app/modules/auth/auth_module.dart';
import 'package:fazentech/app/modules/checkout/screens/credit_card_data/credit_card_data_screen.dart';
import 'package:fazentech/app/modules/checkout/screens/order_success/order_success_screen.dart';
import 'package:fazentech/app/modules/checkout/screens/payment_method/payment_method_screen.dart';
import 'package:fazentech/app/modules/order/screens/order_details/order_details_screen.dart';
import 'package:fazentech/app/modules/order/screens/order_finish/order_finish_screen.dart';
import 'package:fazentech/app/modules/order/screens/orders/orders_screen.dart';
import 'package:fazentech/app/modules/product/submodules/product/product_screen.dart';
import 'package:fazentech/app/modules/splash/splash_screen.dart';
import 'package:fazentech/app/shared/controllers/user_controller.dart';
import 'package:fazentech/app/shared/repositories/auth/auth_repository_firebase.dart';
import 'package:fazentech/app/shared/repositories/auth/auth_repository_interface.dart';
import 'package:fazentech/app/shared/repositories/user/user_repository_firebase.dart';
import 'package:fazentech/app/shared/repositories/user/user_repository_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_widget.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
    Bind<IAuthRepository>((i) => AuthRepositoryFirebase(i.get())),
    Bind<IUserRepository>((i) => UserRepositoryFirebase()),
    Bind((i) => UserController(i.get(), i.get()))
  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter('/', child: (_, __) => SplashScreen()),
    ModularRouter('/main', child: (_, __) => MainScreen()),
    ModularRouter('/auth', module: AuthModule()),
    ModularRouter('/produtos/1', child: (_, __) => ProductScreen(
      title: 'Abacaxi Pérola Unidade',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Est auctor varius pellentesque egestas risus vestibulum enim at pellentesque. Facilisi quis pellentesque nibh laoreet vehicula rhoncus tellus, proin tincidunt. Venenatis eu dictum libero laoreet eleifend augue nullam integer. Non tristique non nibh eu pretium magna fames volutpat, scelerisque. Arcu sagittis cursus sem odio. Turpis vitae interdum magna id commodo.',
      image: 'https://picsum.photos/300/200',
      price: 5.49,
    )),
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