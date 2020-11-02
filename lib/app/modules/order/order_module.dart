import 'package:fazentech/app/modules/order/screens/order_details/order_details_screen.dart';
import 'package:fazentech/app/modules/order/screens/orders/orders_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

class OrderModule extends ChildModule {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRouter> get routers => [
    ModularRouter('/', child: (_, __) => OrdersScreen()),
    ModularRouter('/:id', child: (_, args) => OrderDetailsScreen(args.data))
  ];
}