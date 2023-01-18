part of 'main_bloc.dart';

class MainState extends Equatable {
  final int currentIndex;

  const MainState({
    this.currentIndex = 0,
  });

  MainState copyWith(
    int index,
  ) {
    final newIndex = index;
    return MainState(currentIndex: newIndex);
  }

  @override
  List<Object?> get props => [
        currentIndex,
      ];
}
