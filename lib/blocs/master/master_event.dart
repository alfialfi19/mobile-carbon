part of 'master_bloc.dart';

abstract class MasterEvent extends Equatable {}

class LoadMasterArticleCategory extends MasterEvent {
  @override
  List<Object?> get props => [];
}

class LoadMasterCategory extends MasterEvent {
  @override
  List<Object?> get props => [];
}

class LoadMasterSubCategory extends MasterEvent {
  final int? id;

  LoadMasterSubCategory(this.id);

  @override
  List<Object?> get props => [
        id,
      ];
}
