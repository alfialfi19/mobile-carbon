import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile_carbon/blocs/blocs.dart';
import 'package:mobile_carbon/commons/commons.dart';

import '../../models/models.dart';
import '../../repositories/repositories.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepository commentRepository;

  CommentBloc(this.commentRepository) : super(CommentInitial()) {
    on<LoadComment>(_loadCommentHandler);
    on<DeleteComment>(_deleteCommentHandler);
    on<StoreComment>(_storeCommentHandler);
  }

  Future<void> _loadCommentHandler(
    LoadComment event,
    Emitter<CommentState> emit,
  ) async {
    if (event.currentData != null) {
      emit(ListCommentLoadingPaging());
    } else {
      emit(ListCommentLoading());
    }

    try {
      final response = await commentRepository.getListComment(
        page: event.page,
        id: event.id,
        source: event.source,
      );

      if (event.currentData != null) {
        response.insertAll(0, event.currentData!);
      }

      if (response.isEmpty) {
        return emit(ListCommentEmpty());
      }

      emit(ListCommentLoaded(response));
    } on DioError catch (error) {
      final errorResponse = error.toGenericError();

      return emit(ListCommentError(errorResponse));
    } catch (error) {
      debugPrint("error: $error");
      const errorResponse = GenericErrorResponse(
        errors: 'Something wrong',
        status: false,
        statusCode: 409,
      );

      return emit(const ListCommentError(errorResponse));
    }
  }

  Future<void> _deleteCommentHandler(
    DeleteComment event,
    Emitter<CommentState> emit,
  ) async {
    emit(DeleteCommentLoading());

    try {
      final response = await commentRepository.deleteComment(
        idComment: event.idComment,
      );

      emit(DeleteCommentSuccess());
    } on DioError catch (error) {
      final errorResponse = error.toGenericError();

      return emit(DeleteCommentError(errorResponse));
    } catch (error) {
      debugPrint("error: $error");
      const errorResponse = GenericErrorResponse(
        errors: 'Something wrong',
        status: false,
        statusCode: 409,
      );

      return emit(const DeleteCommentError(errorResponse));
    }
  }

  Future<void> _storeCommentHandler(
    StoreComment event,
    Emitter<CommentState> emit,
  ) async {
    emit(StoreCommentLoading());

    try {
      final response = await commentRepository.storeComment(
        idArticle: event.idArticle,
        idParent: event.idParent,
        idComment: event.idComment,
        desc: event.desc,
        source: event.source,
      );

      emit(StoreCommentSuccess());
    } on DioError catch (error) {
      final errorResponse = error.toGenericError();

      return emit(StoreCommentError(errorResponse));
    } catch (error) {
      debugPrint("error: $error");
      const errorResponse = GenericErrorResponse(
        errors: 'Something wrong',
        status: false,
        statusCode: 409,
      );

      return emit(const StoreCommentError(errorResponse));
    }
  }
}
