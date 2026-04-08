import 'package:mobx/mobx.dart';
import '../model/address_model.dart';
import '../service/home_service.dart';

part 'home_controller.g.dart';

// controller da tela Home — gerencia o estado com MobX
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final _service = HomeService();

  @observable
  AddressModel? address;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  Future<void> searchByCep(String cep) async {
    if (cep.trim().isEmpty) return;

    isLoading = true;
    errorMessage = null;
    address = null;

    try {
      address = await _service.buscarPorCep(cep);
    } catch (e) {
      errorMessage = 'CEP não encontrado. Verifique e tente novamente.';
    } finally {
      isLoading = false;
    }
  }

  @action
  void limparBusca() {
    address = null;
    errorMessage = null;
  }
}
