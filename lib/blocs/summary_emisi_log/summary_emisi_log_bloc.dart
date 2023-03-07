import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile_carbon/blocs/blocs.dart';
import 'package:mobile_carbon/commons/commons.dart';
import 'package:mobile_carbon/models/models.dart';

import '../../repositories/repositories.dart';

part 'summary_emisi_log_event.dart';
part 'summary_emisi_log_state.dart';

class SummaryEmisiLogBloc
    extends Bloc<SummaryEmisiLogEvent, SummaryEmisiLogState> {
  final SummaryRepository summaryRepository;

  SummaryEmisiLogBloc(this.summaryRepository)
      : super(SummaryEmisiLogInitial()) {
    on<LoadSummaryEmisiLog>(_loadSummaryEmisiLogHandler);
  }

  Future<void> _loadSummaryEmisiLogHandler(
    LoadSummaryEmisiLog event,
    Emitter<SummaryEmisiLogState> emit,
  ) async {
    emit(SummaryEmisiLogLoading());

    try {
      final response = await summaryRepository.getSummaryEmisiLog();

      emit(SummaryEmisiLogLoaded(response));
    } on DioError catch (error) {
      final errorResponse = error.toGenericError();

      return emit(SummaryEmisiLogError(errorResponse));
    } catch (error) {
      debugPrint("error: $error");
      const errorResponse = GenericErrorResponse(
        errors: 'Something wrong',
        status: '409',
        statusCode: 409,
      );

      return emit(const SummaryEmisiLogError(errorResponse));
    }
  }
}
