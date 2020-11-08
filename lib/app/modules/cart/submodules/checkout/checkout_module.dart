import 'screens/credit_card_data/credit_card_data_screen.dart';
import 'screens/order_success/order_success_screen.dart';
import 'screens/payment_method/payment_method_screen.dart';
import 'screens/order_finish/order_finish_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CheckoutModule extends ChildModule {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRouter> get routers => [
    ModularRouter('/methods', child: (_, __) => PaymentMethodScreen()),
    ModularRouter('/credit-card', child: (_, __) => CreditCardDataScreen()),
    ModularRouter('/confirmation', child: (_, __) => OrderFinishScreen()),
    ModularRouter('/success', child: (_, __) => OrderSuccessScreen()),
  ];
}