import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile_carbon/blocs/blocs.dart';
import 'package:mobile_carbon/commons/commons.dart';

import '../../models/models.dart';
import '../../repositories/repositories.dart';

part 'eco_activity_event.dart';
part 'eco_activity_state.dart';

class EcoActivityBloc extends Bloc<EcoActivityEvent, EcoActivityState> {
  final EcoActivityRepository ecoActivityRepository;

  EcoActivityBloc(this.ecoActivityRepository) : super(EcoActivityInitial()) {
    on<LoadEcoActivity>(_loadEcoActivityHandler);
    on<LoadEcoActivityDetail>(_loadEcoActivityDetailHandler);
  }

  Future<void> _loadEcoActivityHandler(
      LoadEcoActivity event, Emitter<EcoActivityState> emit) async {
    if (event.currentData != null) {
      emit(ListEcoActivityLoadingPaging());
    } else {
      emit(ListEcoActivityLoading());
    }

    try {
      final response = await ecoActivityRepository.getListEcoActivity(
        page: event.page,
        category: event.category,
        keyword: event.keyword,
        me: event.me,
      );

      if (event.currentData != null) {
        response.insertAll(0, event.currentData!);
      }

      if (response.isEmpty) {
        return emit(ListEcoActivityEmpty());
      }

      emit(ListEcoActivityLoaded(response));
    } on DioError catch (error) {
      final errorResponse = error.toGenericError();

      return emit(ListEcoActivityError(errorResponse));
    } catch (error) {
      debugPrint("error: $error");
      const errorResponse = GenericErrorResponse(
        errors: 'Something wrong',
        status: false,
        statusCode: 409,
      );

      return emit(const ListEcoActivityError(errorResponse));
    }
  }

  Future<void> _loadEcoActivityDetailHandler(
    LoadEcoActivityDetail event,
    Emitter<EcoActivityState> emit,
  ) async {
    emit(DetailEcoActivityLoading());

    try {
      final response = await ecoActivityRepository.getDetailEcoActivity(
        id: event.id,
      );

      emit(DetailEcoActivityLoaded(response));
    } on DioError catch (error) {
      final errorResponse = error.toGenericError();

      return emit(DetailEcoActivityError(errorResponse));
    } catch (error) {
      debugPrint("error: $error");
      const errorResponse = GenericErrorResponse(
        errors: 'Something wrong',
        status: false,
        statusCode: 409,
      );

      return emit(const DetailEcoActivityError(errorResponse));
    }
  }
}
