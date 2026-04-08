import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../controller/history_controller.dart';
import '../../home/components/address_list_widget.dart';
import '../../../shared/colors/app_colors.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final _controller = HistoryController();

  @override
  void initState() {
    super.initState();
    // carrega o histórico automaticamente ao abrir a tela
    _controller.carregarHistorico();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Consultas'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: Observer(
        builder: (_) {
          if (_controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (_controller.enderecos.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history,
                      size: 80,
                      color: AppColors.textLight.withOpacity(0.4)),
                  const SizedBox(height: 16),
                  const Text(
                    'Nenhuma consulta realizada ainda',
                    style:
                        TextStyle(color: AppColors.textLight, fontSize: 16),
                  ),
                ],
              ),
            );
          }

          return AddressListWidget(addresses: _controller.enderecos);
        },
      ),
    );
  }
}
