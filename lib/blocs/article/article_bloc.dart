import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile_carbon/blocs/blocs.dart';
import 'package:mobile_carbon/commons/commons.dart';

import '../../models/models.dart';
import '../../repositories/repositories.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepository articleRepository;

  ArticleBloc(this.articleRepository) : super(ArticleInitial()) {
    on<LoadArticle>(_loadArticleHandler);
    on<LoadArticleDetail>(_loadArticleDetailHandler);
    on<StoreArticle>(_storeArticleHandler);
    on<UpdateArticle>(_updateArticleHandler);
    on<DeleteArticle>(_deleteArticleHandler);
  }

  Future<void> _loadArticleHandler(
      LoadArticle event, Emitter<ArticleState> emit) async {
    if (event.currentData != null) {
      emit(ListArticleLoadingPaging());
    } else {
      emit(ListArticleLoading());
    }

    try {
      final response = await articleRepository.getListArticle(
        page: event.page,
        category: event.category,
        keyword: event.keyword,
        type: event.type,
        me: event.me,
      );

      if (event.currentData != null) {
        response.insertAll(0, event.currentData!);
      }

      if (response.isEmpty) {
        return emit(ListArticleEmpty());
      }

      emit(ListArticleLoaded(response));
    } on DioError catch (error) {
      final errorResponse = error.toGenericError();

      return emit(ListArticleError(errorResponse));
    } catch (error) {
      debugPrint("error: $error");
      const errorResponse = GenericErrorResponse(
        errors: 'Something wrong',
        status: false,
        statusCode: 409,
      );

      return emit(const ListArticleError(errorResponse));
    }
  }

  Future<void> _loadArticleDetailHandler(
    LoadArticleDetail event,
    Emitter<ArticleState> emit,
  ) async {
    emit(DetailArticleLoading());

    try {
      final response = await articleRepository.getDetailArticle(
        id: event.id,
      );

      emit(DetailArticleLoaded(response));
    } on DioError catch (error) {
      final errorResponse = error.toGenericError();

      return emit(DetailArticleError(errorResponse));
    } catch (error) {
      debugPrint("error: $error");
      const errorResponse = GenericErrorResponse(
        errors: 'Something wrong',
        status: false,
        statusCode: 409,
      );

      return emit(const DetailArticleError(errorResponse));
    }
  }

  Future<void> _storeArticleHandler(
    StoreArticle event,
    Emitter<ArticleState> emit,
  ) async {
    emit(StoreArticleLoading());

    try {
      await articleRepository.storeArticle(
        categoryId: event.categoryId,
        title: event.title,
        filePath: event.filePath,
        desc: event.desc,
      );

      emit(StoreArticleSuccess());
    } on DioError catch (error) {
      final errorResponse = error.toGenericError();

      return emit(StoreArticleError(errorResponse));
    } catch (error) {
      debugPrint("error: $error");
      const errorResponse = GenericErrorResponse(
        errors: 'Something wrong',
        status: false,
        statusCode: 409,
      );

      return emit(const StoreArticleError(errorResponse));
    }
  }

  Future<void> _updateArticleHandler(
    UpdateArticle event,
    Emitter<ArticleState> emit,
  ) async {
    emit(UpdateArticleLoading());

    try {
      await articleRepository.updateArticle(
        articleId: event.articleId,
        categoryId: event.categoryId,
        title: event.title,
        filePath: event.filePath,
        desc: event.desc,
      );

      emit(UpdateArticleSuccess());
    } on DioError catch (error) {
      final errorResponse = error.toGenericError();

      return emit(UpdateArticleError(errorResponse));
    } catch (error) {
      debugPrint("error: $error");
      const errorResponse = GenericErrorResponse(
        errors: 'Something wrong',
        status: false,
        statusCode: 409,
      );

      return emit(const UpdateArticleError(errorResponse));
    }
  }

  Future<void> _deleteArticleHandler(
    DeleteArticle event,
    Emitter<ArticleState> emit,
  ) async {
    emit(DeleteArticleLoading());

    try {
      await articleRepository.deleteArticle(
        idArticle: event.idArticle,
      );

      emit(DeleteArticleSuccess());
    } on DioError catch (error) {
      final errorResponse = error.toGenericError();

      return emit(DeleteArticleError(errorResponse));
    } catch (error) {
      debugPrint("error: $error");
      const errorResponse = GenericErrorResponse(
        errors: 'Something wrong',
        status: false,
        statusCode: 409,
      );

      return emit(const DeleteArticleError(errorResponse));
    }
  }
}
