import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const MainState()) {
    on<MainScreenChange>(_mainScreenChange);
  }

  Future<void> _mainScreenChange(
    MainScreenChange event,
    Emitter<MainState> emit,
  ) async {
    if (state.currentIndex != event.index) {
      emit(state.copyWith(event.index));
    }
  }
}
