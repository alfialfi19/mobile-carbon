import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile_carbon/blocs/blocs.dart';
import 'package:mobile_carbon/commons/commons.dart';
import 'package:mobile_carbon/models/models.dart';

import '../../repositories/repositories.dart';

part 'summary_rank_event.dart';
part 'summary_rank_state.dart';

class SummaryRankBloc extends Bloc<SummaryRankEvent, SummaryRankState> {
  final SummaryRepository summaryRepository;

  SummaryRankBloc(this.summaryRepository) : super(SummaryRankInitial()) {
    on<LoadSummaryRank>(_loadSummaryRankHandler);
  }

  Future<void> _loadSummaryRankHandler(
      LoadSummaryRank event, Emitter<SummaryRankState> emit) async {
    emit(SummaryRankLoading());

    try {
      final response = await summaryRepository.getSummaryRank(
        page: event.page,
        type: event.type,
      );

      emit(SummaryRankLoaded(response));
    } on DioError catch (error) {
      final errorResponse = error.toGenericError();

      return emit(SummaryRankError(errorResponse));
    } catch (error) {
      debugPrint("error: $error");
      const errorResponse = GenericErrorResponse(
        errors: 'Something wrong',
        status: '409',
        statusCode: 409,
      );

      return emit(const SummaryRankError(errorResponse));
    }
  }
}
