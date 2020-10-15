import 'dart:convert';

import 'package:fazentech/app/shared/models/order/shipping.dart';
import 'package:xml2json/xml2json.dart';

class ShippingXMLAdapter {
  static Shipping xmlToShipping(String xml) {
    final xmlParser = Xml2Json();
    xmlParser.parse(xml);
    final shippingJson = xmlParser.toParker();
    final shippingMap = json.decode(shippingJson)['Servicos']['cServico'];

    final daysToArrive = int.tryParse(shippingMap['PrazoEntrega']);
    final value = double.tryParse(shippingMap['Valor'].replaceAll(',', '.'));

    return Shipping(
      arrivalForecast: DateTime.now().add(Duration(days: daysToArrive)),
      value: value
    );
  }
}