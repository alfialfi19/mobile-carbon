import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile_carbon/blocs/blocs.dart';
import 'package:mobile_carbon/commons/commons.dart';

import '../../models/models.dart';
import '../../repositories/repositories.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository notificationRepository;

  NotificationBloc(this.notificationRepository) : super(NotificationInitial()) {
    on<LoadNotification>(_loadNotificationHandler);
  }

  Future<void> _loadNotificationHandler(
      LoadNotification event, Emitter<NotificationState> emit,) async {
    emit(ListNotificationLoading());

    try {
      final response = await notificationRepository.getListNotification(
        status: event.status,
      );

      if (response.isEmpty) {
        return emit(ListNotificationEmpty());
      }

      emit(ListNotificationLoaded(response));
    } on DioError catch (error) {
      final errorResponse = error.toGenericError();

      return emit(ListNotificationError(errorResponse));
    } catch (error) {
      debugPrint("error: $error");
      const errorResponse = GenericErrorResponse(
        errors: 'Something wrong',
        status: false,
        statusCode: 409,
      );

      return emit(const ListNotificationError(errorResponse));
    }
  }
}
