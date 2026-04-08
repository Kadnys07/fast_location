import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:geocoding/geocoding.dart';
import 'package:mobx/mobx.dart';

import '../controller/home_controller.dart';
import '../components/last_address_widget.dart';
import '../components/empty_search_widget.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/colors/app_colors.dart';
import '../../../shared/metrics/app_metrics.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = HomeController();
  final _cepController = TextEditingController();

  // lista de reactions para limpar quando sair da tela
  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    super.initState();

    // reage quando ocorre um erro na busca e exibe o snackbar
    _disposers.add(
      reaction((_) => _controller.errorMessage, (String? erro) {
        if (erro != null && erro.isNotEmpty && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(erro), backgroundColor: AppColors.error),
          );
        }
      }),
    );
  }

  @override
  void dispose() {
    for (final d in _disposers) d();
    _cepController.dispose();
    super.dispose();
  }

  // abre o mapa com o endereço do último CEP consultado
  Future<void> _tracarRota() async {
    // mapa não funciona no web
    if (kIsWeb) {
      _mostrarMensagem('Traçar rota está disponível apenas no app mobile.');
      return;
    }

    final endereco = _controller.address;
    if (endereco == null) return;

    try {
      // converte o endereço em coordenadas geográficas
      final locais = await locationFromAddress(endereco.fullAddress);
      if (locais.isEmpty) {
        _mostrarMensagem('Não foi possível encontrar o endereço no mapa.');
        return;
      }

      final coord = Coords(locais.first.latitude, locais.first.longitude);
      final mapas = await MapLauncher.installedMaps;

      if (mapas.isEmpty) {
        _mostrarMensagem('Nenhum app de mapa encontrado no dispositivo.');
        return;
      }

      await mapas.first.showMarker(coords: coord, title: endereco.fullAddress);
    } catch (e) {
      _mostrarMensagem('Erro ao abrir o mapa.');
    }
  }

  void _mostrarMensagem(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: AppColors.error),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FastLocation'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Histórico',
            onPressed: () => Navigator.pushNamed(context, AppRoutes.history),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildBarraBusca(),
          Expanded(
            child: Observer(
              builder: (_) {
                // mostra loading enquanto busca
                if (_controller.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                }

                // mostra widget de não encontrado se houve erro
                if (_controller.errorMessage != null) {
                  return const EmptySearchWidget();
                }

                // mostra o endereço encontrado
                if (_controller.address != null) {
                  return SingleChildScrollView(
                    child: LastAddressWidget(
                      address: _controller.address!,
                      onRoutePressed: _tracarRota,
                    ),
                  );
                }

                // estado inicial — aguardando busca
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search,
                          size: 80,
                          color: AppColors.textLight.withOpacity(0.4)),
                      const SizedBox(height: 16),
                      const Text(
                        'Digite um CEP para consultar',
                        style:
                            TextStyle(color: AppColors.textLight, fontSize: 16),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarraBusca() {
    return Container(
      padding: const EdgeInsets.all(AppMetrics.paddingMedium),
      color: AppColors.primary,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _cepController,
              keyboardType: TextInputType.number,
              maxLength: 9,
              style: const TextStyle(color: AppColors.white),
              decoration: InputDecoration(
                hintText: 'Digite o CEP (ex: 01310-100)',
                hintStyle: TextStyle(color: AppColors.white.withOpacity(0.7)),
                counterText: '',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppMetrics.borderRadius),
                  borderSide:
                      BorderSide(color: AppColors.white.withOpacity(0.5)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppMetrics.borderRadius),
                  borderSide:
                      BorderSide(color: AppColors.white.withOpacity(0.5)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppMetrics.borderRadius),
                  borderSide: const BorderSide(color: AppColors.white),
                ),
              ),
              onSubmitted: (cep) => _controller.searchByCep(cep),
            ),
          ),
          const SizedBox(width: 8),
          Observer(
            builder: (_) => ElevatedButton(
              onPressed: _controller.isLoading
                  ? null
                  : () => _controller.searchByCep(_cepController.text),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: AppColors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppMetrics.borderRadius),
                ),
              ),
              child: const Icon(Icons.search),
            ),
          ),
        ],
      ),
    );
  }
}
