import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile_carbon/blocs/blocs.dart';
import 'package:mobile_carbon/commons/commons.dart';

import '../../models/models.dart';
import '../../repositories/repositories.dart';

part 'emisi_log_event.dart';
part 'emisi_log_state.dart';

class EmisiLogBloc extends Bloc<EmisiLogEvent, EmisiLogState> {
  final EmisiLogRepository emisiLogRepository;

  EmisiLogBloc(this.emisiLogRepository) : super(EmisiLogInitial()) {
    on<LoadEmisiLog>(_loadEmisiLogHandler);
  }

  Future<void> _loadEmisiLogHandler(
    LoadEmisiLog event,
    Emitter<EmisiLogState> emit,
  ) async {
    emit(EmisiLogLoading());

    try {
      final response = await emisiLogRepository.getEmisiLog(
        page: event.page,
      );

      if (response.isEmpty) {
        return emit(EmisiLogEmpty());
      }

      emit(EmisiLogLoaded(response));
    } on DioError catch (error) {
      final errorResponse = error.toGenericError();

      return emit(EmisiLogError(errorResponse));
    } catch (error) {
      debugPrint("error: $error");
      const errorResponse = GenericErrorResponse(
        errors: 'Something wrong',
        status: false,
        statusCode: 409,
      );

      return emit(const EmisiLogError(errorResponse));
    }
  }
}
