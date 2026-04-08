import 'package:flutter/material.dart';
import '../model/address_model.dart';
import '../../../shared/colors/app_colors.dart';
import '../../../shared/metrics/app_metrics.dart';

class AddressListWidget extends StatelessWidget {
  final List<AddressModel> addresses;
  final Function(AddressModel)? onTap;

  const AddressListWidget({
    Key? key,
    required this.addresses,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: addresses.length,
      itemBuilder: (context, index) {
        final address = addresses[index];
        return Card(
          margin: const EdgeInsets.symmetric(
            horizontal: AppMetrics.paddingMedium,
            vertical: AppMetrics.paddingSmall / 2,
          ),
          child: ListTile(
            leading: const Icon(Icons.location_on, color: AppColors.primary),
            title: Text(
              address.cep ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            subtitle: Text(
              address.fullAddress,
              style: const TextStyle(color: AppColors.textLight),
            ),
            onTap: onTap != null ? () => onTap!(address) : null,
          ),
        );
      },
    );
  }
}
