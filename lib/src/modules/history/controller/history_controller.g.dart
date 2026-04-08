// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HistoryController on _HistoryControllerBase, Store {
  late final _$enderecosAtom =
      Atom(name: '_HistoryControllerBase.enderecos', context: context);

  @override
  ObservableList<AddressModel> get enderecos {
    _$enderecosAtom.reportRead();
    return super.enderecos;
  }

  @override
  set enderecos(ObservableList<AddressModel> value) {
    _$enderecosAtom.reportWrite(value, super.enderecos, () {
      super.enderecos = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_HistoryControllerBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$carregarHistoricoAsyncAction =
      AsyncAction('_HistoryControllerBase.carregarHistorico', context: context);

  @override
  Future<void> carregarHistorico() {
    return _$carregarHistoricoAsyncAction.run(() => super.carregarHistorico());
  }

  @override
  String toString() {
    return '''
enderecos: ${enderecos},
isLoading: ${isLoading}
    ''';
  }
}
