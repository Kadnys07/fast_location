import 'package:mobx/mobx.dart';
import '../../home/model/address_model.dart';
import '../../home/service/home_service.dart';

part 'history_controller.g.dart';

// controller do histórico — carrega os endereços salvos localmente
class HistoryController = _HistoryControllerBase with _$HistoryController;

abstract class _HistoryControllerBase with Store {
  final _service = HomeService();

  @observable
  ObservableList<AddressModel> enderecos = ObservableList();

  @observable
  bool isLoading = false;

  @action
  Future<void> carregarHistorico() async {
    isLoading = true;
    enderecos = ObservableList.of(_service.buscarHistorico());
    isLoading = false;
  }
}
