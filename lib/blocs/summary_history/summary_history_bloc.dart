import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile_carbon/blocs/bloc_state.dart';
import 'package:mobile_carbon/commons/commons.dart';
import 'package:mobile_carbon/models/models.dart';

import '../../repositories/repositories.dart';

part 'summary_history_event.dart';
part 'summary_history_state.dart';

class SummaryHistoryBloc
    extends Bloc<SummaryHistoryEvent, SummaryHistoryState> {
  final SummaryRepository summaryRepository;

  SummaryHistoryBloc(this.summaryRepository) : super(SummaryHistoryInitial()) {
    on<LoadSummaryHistory>(_loadSummaryHistoryHandler);
  }

  Future<void> _loadSummaryHistoryHandler(
    LoadSummaryHistory event,
    Emitter<SummaryHistoryState> emit,
  ) async {
    emit(SummaryHistoryLoading());

    try {
      final response = await summaryRepository.getSummaryHistory(
        page: event.page,
        type: event.type,
      );

      emit(SummaryHistoryLoaded(response));
    } on DioError catch (error) {
      final errorResponse = error.toGenericError();

      return emit(SummaryHistoryError(errorResponse));
    } catch (error) {
      debugPrint("error: $error");
      const errorResponse = GenericErrorResponse(
        errors: 'Something wrong',
        status: '409',
        statusCode: 409,
      );

      return emit(const SummaryHistoryError(errorResponse));
    }
  }
}
