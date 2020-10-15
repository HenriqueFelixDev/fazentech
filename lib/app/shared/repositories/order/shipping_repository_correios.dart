import 'package:dio/dio.dart';
import 'package:fazentech/app/shared/adapter/shipping/shipping_xml_adapter.dart';
import 'package:fazentech/app/shared/models/order/shipping.dart';
import 'package:fazentech/app/shared/repositories/order/shipping_repository_interface.dart';

class ShippingRepositoryCorreios implements IShippingRepository {
  static const _baseURL = 'http://ws.correios.com.br/calculador/CalcPrecoPrazo.aspx';
  final dio = Dio(BaseOptions(baseUrl: _baseURL, responseType: ResponseType.plain));

  @override
  Future<List<Shipping>> getShippings(String cep) async{
    List<Shipping> shippings = [];
    shippings.add(await getShipping('SEDEX', '04014', cep));
    shippings.add(await getShipping('PAC', '04510', cep));
    return shippings;
  }

  Future<Shipping> getShipping(String serviceName, String serviceCode, String destinationCEP) async{
    final response = await dio.get<String>(
      '?nCdEmpresa&sDsSenha&'+
      'nCdServico=$serviceCode&'+
      'sCepOrigem=01001000&'+
      'sCepDestino=$destinationCEP&'+
      'nVlPeso=1&'+
      'nCdFormato=1&'+
      'nVlComprimento=60&'+
      'nVlAltura=20&'+
      'nVlLargura=40&'+
      'nVlDiametro=30&'+
      'sCdMaoPropria=N&'+
      'nVlValorDeclarado=0&'+
      'sCdAvisoRecebimento=N&'+
      'StrRetorno=xml&nIndicaCalculo=3'
    );

    final shipping = ShippingXMLAdapter.xmlToShipping(response.data);
    shipping.type = serviceName;
    shipping.postalCode = destinationCEP;
    
    return shipping;
  }

}