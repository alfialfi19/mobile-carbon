part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {}

class MainScreenChange extends MainEvent {
  final int index;

  MainScreenChange({
    required this.index,
  });

  @override
  List<Object> get props => [
        index,
      ];
}
