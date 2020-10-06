import 'package:fazentech/app/modules/account/account_screen.dart';
import 'package:fazentech/app/modules/auth/signup_address_screen.dart';
import 'package:fazentech/app/modules/auth/sigup_screen.dart';
import 'package:fazentech/app/modules/cart/cart_screen.dart';
import 'package:fazentech/app/modules/checkout/screens/credit_card_data/credit_card_data_screen.dart';
import 'package:fazentech/app/modules/checkout/screens/order_confirmation/order_confirmation_screen.dart';
import 'package:fazentech/app/modules/checkout/screens/payment_method/payment_method_screen.dart';
import 'package:fazentech/app/modules/home/home_screen.dart';
import 'package:fazentech/app/modules/order/screens/order_details/order_details_screen.dart';
import 'package:fazentech/app/modules/order/screens/order_finish/order_finish_screen.dart';
import 'package:fazentech/app/modules/order/screens/orders/orders_screen.dart';
import 'package:fazentech/app/modules/product/submodules/categories/categories_screen.dart';
import 'package:fazentech/app/modules/product/submodules/product/product_screen.dart';
import 'package:fazentech/app/modules/product/submodules/products/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_widget.dart';
import 'modules/auth/login_screen.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRouter> get routers => [
    //ModularRouter('/', child: (_, __) => HomeScreen()),
    //ModularRouter('/', child: (_, __) => ProductsScreen()),
    //ModularRouter('/', child: (_, __) => PaymentMethodScreen()),
    ModularRouter('/login', child: (_, __) => LoginScreen()),
    ModularRouter('/cadastro', child: (_, __) => SignUpScreen()),
    ModularRouter('/cadastro/endereco', child: (_, __) => SignUpAddressScreen()),
    ModularRouter('/categorias', child: (_, __) => CategoriesScreen()),
    ModularRouter('/produtos/1', child: (_, __) => ProductScreen(
      title: 'Abacaxi Pérola Unidade',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Est auctor varius pellentesque egestas risus vestibulum enim at pellentesque. Facilisi quis pellentesque nibh laoreet vehicula rhoncus tellus, proin tincidunt. Venenatis eu dictum libero laoreet eleifend augue nullam integer. Non tristique non nibh eu pretium magna fames volutpat, scelerisque. Arcu sagittis cursus sem odio. Turpis vitae interdum magna id commodo.',
      image: 'https://picsum.photos/300/200',
      price: 5.49,
    )),
    ModularRouter('/checkout/credit-card', child: (_, __) => CreditCardDataScreen()),
    ModularRouter('/checkout/confirmation', child: (_, __) => OrderConfirmationScreen()),
    //ModularRouter('/', child: (_, __) => AccountScreen()),
    //ModularRouter('/', child: (_, __) => OrdersScreen()),
    //ModularRouter('/', child: (_, __) => OrderDetailsScreen()),
    //ModularRouter('/', child: (_, __) => OrderFinishScreen()),
    ModularRouter('/', child: (_, __) => CartScreen())
  ];

  @override
  Widget get bootstrap => AppWidget();
}