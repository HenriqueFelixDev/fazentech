import 'package:fazentech/app/shared/models/order/shipping.dart';

abstract class IShippingRepository {
  Future<List<Shipping>> getShippings(String cep);
}