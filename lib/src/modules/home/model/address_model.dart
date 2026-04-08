import 'package:hive/hive.dart';

part 'address_model.g.dart';

@HiveType(typeId: 0)
class AddressModel {
  @HiveField(0)
  final String? cep;

  @HiveField(1)
  final String? logradouro;

  @HiveField(2)
  final String? complemento;

  @HiveField(3)
  final String? bairro;

  @HiveField(4)
  final String? localidade;

  @HiveField(5)
  final String? uf;

  @HiveField(6)
  final String? ibge;

  @HiveField(7)
  final String? gia;

  @HiveField(8)
  final String? ddd;

  @HiveField(9)
  final String? siafi;

  AddressModel({
    this.cep,
    this.logradouro,
    this.complemento,
    this.bairro,
    this.localidade,
    this.uf,
    this.ibge,
    this.gia,
    this.ddd,
    this.siafi,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      cep: json['cep'],
      logradouro: json['logradouro'],
      complemento: json['complemento'],
      bairro: json['bairro'],
      localidade: json['localidade'],
      uf: json['uf'],
      ibge: json['ibge'],
      gia: json['gia'],
      ddd: json['ddd'],
      siafi: json['siafi'],
    );
  }

  String get fullAddress {
    final parts = <String>[];
    if (logradouro != null && logradouro!.isNotEmpty) parts.add(logradouro!);
    if (bairro != null && bairro!.isNotEmpty) parts.add(bairro!);
    if (localidade != null && localidade!.isNotEmpty) parts.add(localidade!);
    if (uf != null && uf!.isNotEmpty) parts.add(uf!);
    return parts.join(', ');
  }
}
