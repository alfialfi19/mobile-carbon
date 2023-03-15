part of 'emisi_log_bloc.dart';

abstract class EmisiLogEvent extends Equatable {}

class LoadEmisiLog extends EmisiLogEvent {
  final int? page;

  LoadEmisiLog(this.page);

  @override
  List<Object?> get props => [
        page,
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
