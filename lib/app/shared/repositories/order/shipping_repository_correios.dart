import 'package:http/http.dart' as http;

import 'shipping_repository_interface.dart';
import '../../adapter/shipping/shipping_xml_adapter.dart';
import '../../models/order/shipping.dart';

class ShippingRepositoryCorreios implements IShippingRepository {
  static const _baseURL = 'http://ws.correios.com.br/calculador/CalcPrecoPrazo.aspx';

  @override
  Future<List<Shipping>> getShippings(String cep) async{
    List<Shipping> shippings = [];
    shippings.add(await _getShipping('PAC', '04510', cep));
    shippings.add(await _getShipping('SEDEX', '04014', cep));
    return shippings;
  }

  Future<Shipping> _getShipping(String serviceName, String serviceCode, String destinationCEP) async{
    final response = await http.get(
      _baseURL +
      '?nCdEmpresa&sDsSenha&' +
      'nCdServico=$serviceCode&' +
      'sCepOrigem=01001000&' +
      'sCepDestino=$destinationCEP&' +
      'nVlPeso=1&' +
      'nCdFormato=1&' +
      'nVlComprimento=60&' +
      'nVlAltura=20&' +
      'nVlLargura=40&' +
      'nVlDiametro=30&' +
      'sCdMaoPropria=N&' +
      'nVlValorDeclarado=0&' +
      'sCdAvisoRecebimento=N&' +
      'StrRetorno=xml&nIndicaCalculo=3'
    );

    final shipping = ShippingXMLAdapter.xmlToShipping(response.body);
    shipping.type = serviceName;
    shipping.postalCode = destinationCEP;
    
    return shipping;
  }

}