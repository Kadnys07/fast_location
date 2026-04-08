import 'package:dio/dio.dart';
import '../model/address_model.dart';
import '../../../http/http_client.dart';

class CepRepository {
  final Dio _dio = HttpClient.createDio();

  Future<AddressModel> fetchByCep(String cep) async {
    final cleanCep = cep.replaceAll(RegExp(r'[^0-9]'), '');
    final response = await _dio.get('$cleanCep/json/');

    if (response.data['erro'] == true || response.data['erro'] == 'true') {
      throw Exception('CEP não encontrado');
    }

    return AddressModel.fromJson(response.data);
  }
}
