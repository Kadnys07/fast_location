import 'package:flutter/material.dart';
import '../model/address_model.dart';
import '../../../shared/colors/app_colors.dart';
import '../../../shared/metrics/app_metrics.dart';

class LastAddressWidget extends StatelessWidget {
  final AddressModel address;
  final VoidCallback? onRoutePressed;

  const LastAddressWidget({
    Key? key,
    required this.address,
    this.onRoutePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(AppMetrics.paddingMedium),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppMetrics.borderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppMetrics.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.location_on, color: AppColors.primary, size: 28),
                const SizedBox(width: 8),
                Text(
                  address.cep ?? '',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const Divider(),
            _buildRow('Logradouro', address.logradouro),
            _buildRow('Complemento', address.complemento),
            _buildRow('Bairro', address.bairro),
            _buildRow('Cidade', address.localidade),
            _buildRow('Estado', address.uf),
            _buildRow('DDD', address.ddd),
            const SizedBox(height: AppMetrics.paddingMedium),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onRoutePressed,
                icon: const Icon(Icons.map),
                label: const Text('Traçar Rota'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppMetrics.borderRadius),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textLight,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: AppColors.text),
            ),
          ),
        ],
      ),
    );
  }
}
