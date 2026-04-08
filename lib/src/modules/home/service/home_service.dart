import '../model/address_model.dart';
import '../repositories/cep_repository.dart';
import '../repositories/cep_local_repository.dart';

// camada de serviço — aqui ficam as regras de negócio
class HomeService {
  final _apiRepo = CepRepository();
  final _localRepo = CepLocalRepository();

  Future<AddressModel> buscarPorCep(String cep) async {
    // busca na API externa
    final endereco = await _apiRepo.fetchByCep(cep);
    // salva no histórico local após cada consulta
    await _localRepo.salvar(endereco);
    return endereco;
  }

  List<AddressModel> buscarHistorico() {
    return _localRepo.buscarTodos();
  }
}
