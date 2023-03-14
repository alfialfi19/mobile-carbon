import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile_carbon/blocs/blocs.dart';
import 'package:mobile_carbon/commons/commons.dart';

import '../../models/models.dart';
import '../../repositories/repositories.dart';

part 'donation_event.dart';
part 'donation_state.dart';

class DonationBloc extends Bloc<DonationEvent, DonationState> {
  final DonationRepository donationRepository;

  DonationBloc(this.donationRepository) : super(DonationInitial()) {
    on<LoadDonationList>(_loadDonationListHandler);
    on<LoadDonationDetail>(_loadDonationDetailHandler);
  }

  Future<void> _loadDonationListHandler(
      LoadDonationList event, Emitter<DonationState> emit) async {
    emit(ListDonationLoading());

    try {
      final response = await donationRepository.getListDonation(
        page: event.page,
        category: event.category,
        keyword: event.keyword,
      );

      if (response.isEmpty) {
        return emit(ListDonationEmpty());
      }

      emit(ListDonationLoaded(response));
    } on DioError catch (error) {
      final errorResponse = error.toGenericError();

      return emit(ListDonationError(errorResponse));
    }
  }

  Future<void> _loadDonationDetailHandler(
    LoadDonationDetail event,
    Emitter<DonationState> emit,
  ) async {
    emit(DetailDonationLoading());

    try {
      final response = await donationRepository.getDetailDonation(
        id: event.id,
      );

      emit(DetailDonationLoaded(response));
    } on DioError catch (error) {
      final errorResponse = error.toGenericError();

      return emit(DetailDonationError(errorResponse));
    } catch (error) {
      debugPrint("error: $error");
      const errorResponse = GenericErrorResponse(
        errors: 'Something wrong',
        status: false,
        statusCode: 409,
      );

      return emit(const DetailDonationError(errorResponse));
    }
  }
}
