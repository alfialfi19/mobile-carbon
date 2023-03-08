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
  }

  Future<void> _loadEcoActivityHandler(
      LoadEcoActivity event, Emitter<EcoActivityState> emit) async {
    emit(ListEcoActivityLoading());

    try {
      final response = await ecoActivityRepository.getListEcoActivity(
        page: event.page,
        category: event.category,
        keyword: event.keyword,
      );

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
        status: '409',
        statusCode: 409,
      );

      return emit(const ListEcoActivityError(errorResponse));
    }
  }
}
