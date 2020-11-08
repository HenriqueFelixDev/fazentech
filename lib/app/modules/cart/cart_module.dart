import 'package:fazentech/app/modules/cart/cart_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'cart_screen.dart';
import 'submodules/checkout/checkout_module.dart';

class CartModule extends ChildModule {
  @override
  List<Bind> get binds => [
    Bind((i) => CartController(i.get()))
  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter('/', child: (_, __) => CartScreen()),
    ModularRouter('/checkout', module: CheckoutModule())
  ];
}