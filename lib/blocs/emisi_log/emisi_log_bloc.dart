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
    on<StoreEmisiLog>(_storeEmisiLogHandler);
  }

  Future<void> _loadEmisiLogHandler(
    LoadEmisiLog event,
    Emitter<EmisiLogState> emit,
  ) async {
    if (event.currentData != null) {
      emit(EmisiLogLoadingPaging());
    } else {
      emit(EmisiLogLoading());
    }

    try {
      final response = await emisiLogRepository.getEmisiLog(
        page: event.page,
      );

      if (event.currentData != null) {
        response.insertAll(0, event.currentData!);
      }

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

  Future<void> _storeEmisiLogHandler(
    StoreEmisiLog event,
    Emitter<EmisiLogState> emit,
  ) async {
    emit(StoreEmisiLogLoading());

    try {
      await emisiLogRepository.storeEmisiLog(
        idCategory: event.idCategory,
        idSubCategory: event.idSubCategory,
        val: event.val,
        unit: event.unit,
      );

      emit(StoreEmisiLogSuccess());
    } on DioError catch (error) {
      final errorResponse = error.toGenericError();

      return emit(StoreEmisiLogError(errorResponse));
    } catch (error) {
      debugPrint("error: $error");
      const errorResponse = GenericErrorResponse(
        errors: 'Something wrong',
        status: false,
        statusCode: 409,
      );

      return emit(const StoreEmisiLogError(errorResponse));
    }
  }
}
