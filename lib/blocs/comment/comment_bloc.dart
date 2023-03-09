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
  }

  Future<void> _loadCommentHandler(
    LoadComment event,
    Emitter<CommentState> emit,
  ) async {
    emit(ListCommentLoading());

    try {
      final response = await commentRepository.getListComment(
        page: event.page,
        id: event.id,
      );

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
        status: '409',
        statusCode: 409,
      );

      return emit(const ListCommentError(errorResponse));
    }
  }
}
