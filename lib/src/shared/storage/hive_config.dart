import 'package:hive_flutter/hive_flutter.dart';
import '../../modules/home/model/address_model.dart';

// configuração do banco de dados local (Hive)
class HiveConfig {
  static const String boxEnderecos = 'enderecos';

  static Future<void> init() async {
    await Hive.initFlutter();
    // registra o adapter gerado automaticamente pelo build_runner
    Hive.registerAdapter(AddressModelAdapter());
    await Hive.openBox<AddressModel>(boxEnderecos);
  }

  static Box<AddressModel> getBox() {
    return Hive.box<AddressModel>(boxEnderecos);
  }
}
