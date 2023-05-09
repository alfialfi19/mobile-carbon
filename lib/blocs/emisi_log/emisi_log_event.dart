part of 'emisi_log_bloc.dart';

abstract class EmisiLogEvent extends Equatable {}

class LoadEmisiLog extends EmisiLogEvent {
  final int? page;
  final List<EmisiLog>? currentData;

  LoadEmisiLog({
    this.page,
    this.currentData,
  });

  @override
  List<Object?> get props => [
        page,
        currentData,
      ];
}

class StoreEmisiLog extends EmisiLogEvent {
  final String? idCategory;
  final String? idSubCategory;
  final String? val;
  final String? unit;

  StoreEmisiLog(
    this.idCategory,
    this.idSubCategory,
    this.val,
    this.unit,
  );

  @override
  List<Object?> get props => [
        idCategory,
        idSubCategory,
        val,
        unit,
      ];
}

class StoreEmisiLogMultiple extends EmisiLogEvent {
  final List<EmisiCategory>? listEmisi;
  final List<String>? listVal;

  StoreEmisiLogMultiple({
    this.listEmisi,
    this.listVal,
  });

  @override
  List<Object?> get props => [
        listEmisi,
        listVal,
      ];
}
