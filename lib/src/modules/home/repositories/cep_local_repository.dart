import '../model/address_model.dart';
import '../../../shared/storage/hive_config.dart';

// repositório responsável por salvar e ler os endereços localmente
class CepLocalRepository {
  Future<void> salvar(AddressModel endereco) async {
    final box = HiveConfig.getBox();
    // usa o CEP como chave para evitar duplicatas
    await box.put(endereco.cep, endereco);
  }

  List<AddressModel> buscarTodos() {
    final box = HiveConfig.getBox();
    // retorna do mais recente para o mais antigo
    return box.values.toList().reversed.toList();
  }
}
