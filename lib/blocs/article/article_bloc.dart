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
  }

  Future<void> _loadArticleHandler(
      LoadArticle event, Emitter<ArticleState> emit) async {
    emit(ListArticleLoading());

    try {
      final response = await articleRepository.getListArticle(
        page: event.page,
        category: event.category,
        keyword: event.keyword,
        type: event.type,
      );

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
        status: '409',
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
        status: '409',
        statusCode: 409,
      );

      return emit(const DetailArticleError(errorResponse));
    }
  }
}
