part of 'eco_activity_bloc.dart';

abstract class EcoActivityEvent extends Equatable {}

class LoadEcoActivity extends EcoActivityEvent {
  final int? page;
  final int? category;
  final String? keyword;

  LoadEcoActivity(
    this.page,
    this.category,
    this.keyword,
  );

  @override
  List<Object?> get props => [
        page,
        category,
        keyword,
      ];
}
