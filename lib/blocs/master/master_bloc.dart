import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile_carbon/blocs/blocs.dart';
import 'package:mobile_carbon/commons/commons.dart';

import '../../models/models.dart';
import '../../repositories/repositories.dart';

part 'master_event.dart';
part 'master_state.dart';

class MasterBloc extends Bloc<MasterEvent, MasterState> {
  final MasterRepository masterRepository;

  MasterBloc(this.masterRepository) : super(MasterInitial()) {
    on<LoadMasterArticleCategory>(_loadMasterArticleCategoryHandler);
    on<LoadMasterCategory>(_loadMasterCategoryHandler);
    on<LoadMasterSubCategory>(_loadMasterSubCategoryHandler);
  }

  Future<void> _loadMasterArticleCategoryHandler(
    LoadMasterArticleCategory event,
    Emitter<MasterState> emit,
  ) async {
    emit(MasterArticleCategoryLoading());

    try {
      final response = await masterRepository.getArticleCategory();

      if (response.isEmpty) {
        return emit(MasterArticleCategoryEmpty());
      }

      emit(MasterArticleCategoryLoaded(response));
    } on DioError catch (error) {
      final errorResponse = error.toGenericError();

      return emit(MasterArticleCategoryError(errorResponse));
    } catch (error) {
      debugPrint("error: $error");
      const errorResponse = GenericErrorResponse(
        errors: 'Something wrong',
        status: false,
        statusCode: 409,
      );

      return emit(const MasterArticleCategoryError(errorResponse));
    }
  }

  Future<void> _loadMasterCategoryHandler(
    LoadMasterCategory event,
    Emitter<MasterState> emit,
  ) async {
    emit(MasterCategoryLoading());

    try {
      final response = await masterRepository.getEmisiCategory();

      if (response.isEmpty) {
        return emit(MasterCategoryEmpty());
      }

      emit(MasterCategoryLoaded(response));
    } on DioError catch (error) {
      final errorResponse = error.toGenericError();

      return emit(MasterCategoryError(errorResponse));
    } catch (error) {
      debugPrint("error: $error");
      const errorResponse = GenericErrorResponse(
        errors: 'Something wrong',
        status: false,
        statusCode: 409,
      );

      return emit(const MasterCategoryError(errorResponse));
    }
  }

  Future<void> _loadMasterSubCategoryHandler(
    LoadMasterSubCategory event,
    Emitter<MasterState> emit,
  ) async {
    emit(MasterSubCategoryLoading());

    try {
      final response = await masterRepository.getEmisiSubCategory(
        id: event.id,
      );

      if (response.isEmpty) {
        return emit(MasterSubCategoryEmpty());
      }

      emit(MasterSubCategoryLoaded(response));
    } on DioError catch (error) {
      final errorResponse = error.toGenericError();

      return emit(MasterSubCategoryError(errorResponse));
    } catch (error) {
      debugPrint("error: $error");
      const errorResponse = GenericErrorResponse(
        errors: 'Something wrong',
        status: false,
        statusCode: 409,
      );

      return emit(const MasterSubCategoryError(errorResponse));
    }
  }
}
