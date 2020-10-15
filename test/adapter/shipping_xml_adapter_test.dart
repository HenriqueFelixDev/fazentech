import 'package:fazentech/app/shared/adapter/shipping/shipping_xml_adapter.dart';
import 'package:fazentech/app/shared/models/order/shipping.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Transformando xml em um objeto Shipping', () {
    final xml = 
    '''<?xml version="1.0" encoding="ISO-8859-1" ?>
        <Servicos>
          <cServico>
            <Codigo>04014</Codigo>
            <Valor>48,80</Valor>
            <PrazoEntrega>7</PrazoEntrega>
            <ValorSemAdicionais>48,80</ValorSemAdicionais>
            <ValorMaoPropria>0,00</ValorMaoPropria>
            <ValorAvisoRecebimento>0,00</ValorAvisoRecebimento>
            <ValorValorDeclarado>0,00</ValorValorDeclarado>
            <EntregaDomiciliar>S</EntregaDomiciliar>
            <EntregaSabado>N</EntregaSabado>
            <obsFim></obsFim>
            <Erro>0</Erro>
            <MsgErro></MsgErro>
          </cServico>
        </Servicos>''';
    expect(ShippingXMLAdapter.xmlToShipping(xml), isA<Shipping>());
    expect(ShippingXMLAdapter.xmlToShipping(xml).arrivalForecast.day, 20);
    expect(ShippingXMLAdapter.xmlToShipping(xml).arrivalForecast.month, 10);
    expect(ShippingXMLAdapter.xmlToShipping(xml).arrivalForecast.year, 2020);
    expect(ShippingXMLAdapter.xmlToShipping(xml).value, 48.8);
  });
}