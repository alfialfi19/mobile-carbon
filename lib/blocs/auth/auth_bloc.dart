import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile_carbon/blocs/blocs.dart';
import 'package:mobile_carbon/commons/commons.dart';
import 'package:mobile_carbon/models/models.dart';

import '../../repositories/repositories.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<SignIn>(_signInHandler);
    on<SignInGoogle>(_signInGoogleHandler);
    on<Register>(_registerHandler);
    on<ForgetPassword>(_forgetPasswordHandler);
    on<LoadDetailAccount>(_loadDetailAccountHandler);
    on<StoreUpdateAccount>(_storeUpdateAccountHandler);
  }

  Future<void> _signInHandler(
    SignIn event,
    Emitter<AuthState> emit,
  ) async {
    emit(SignInLoading());

    try {
      final response = await authRepository.signIn(
        email: event.email,
        password: event.password,
      );

      emit(SignInSuccess(response));
    } on DioError catch (error) {
      final errorResponse = error.toGenericError();

      return emit(SignInFailed(errorResponse));
    } catch (error) {
      debugPrint("error: $error");
      const errorResponse = GenericErrorResponse(
        errors: 'Something wrong',
        status: false,
        statusCode: 409,
      );

      return emit(const SignInFailed(errorResponse));
    }
  }

  Future<void> _signInGoogleHandler(
    SignInGoogle event,
    Emitter<AuthState> emit,
  ) async {
    emit(SignInLoading());

    try {
      final response = await authRepository.signInGoogle(
        email: event.email,
        fullName: event.fullName,
        idExternal: event.idExternal,
        token: event.token,
      );

      emit(SignInSuccess(response));
    } on DioError catch (error) {
      final errorResponse = error.toGenericError();

      return emit(SignInFailed(errorResponse));
    } catch (error) {
      debugPrint("error: $error");
      const errorResponse = GenericErrorResponse(
        errors: 'Something wrong',
        status: false,
        statusCode: 409,
      );

      return emit(const SignInFailed(errorResponse));
    }
  }

  Future<void> _registerHandler(
    Register event,
    Emitter<AuthState> emit,
  ) async {
    emit(RegisterLoading());

    try {
      final response = await authRepository.register(
        fullName: event.fullName,
        email: event.email,
        password: event.password,
      );

      emit(RegisterSuccess(response));
    } on DioError catch (error) {
      final errorResponse = error.toGenericError();

      return emit(RegisterFailed(errorResponse));
    } catch (error) {
      debugPrint("error: $error");
      const errorResponse = GenericErrorResponse(
        errors: 'Something wrong',
        status: false,
        statusCode: 409,
      );

      return emit(const RegisterFailed(errorResponse));
    }
  }

  Future<void> _forgetPasswordHandler(
    ForgetPassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(ForgetPasswordLoading());

    try {
      final response = await authRepository.forgetPassword(
        email: event.email,
      );

      emit(ForgetPasswordSuccess(response));
    } on DioError catch (error) {
      final errorResponse = error.toGenericError();

      return emit(ForgetPasswordFailed(errorResponse));
    } catch (error) {
      debugPrint("error: $error");
      const errorResponse = GenericErrorResponse(
        errors: 'Something wrong',
        status: false,
        statusCode: 409,
      );

      return emit(const ForgetPasswordFailed(errorResponse));
    }
  }

  Future<void> _loadDetailAccountHandler(
    LoadDetailAccount event,
    Emitter<AuthState> emit,
  ) async {
    emit(DetailAccountLoading());

    try {
      final response = await authRepository.getAccountDetail();

      emit(DetailAccountLoaded(response));
    } on DioError catch (error) {
      final errorResponse = error.toGenericError();

      return emit(DetailAccountError(errorResponse));
    }
  }

  Future<void> _storeUpdateAccountHandler(
    StoreUpdateAccount event,
    Emitter<AuthState> emit,
  ) async {
    emit(StoreAccountUpdateLoading());

    try {
      await authRepository.storeAccountUpdate(
        name: event.name,
        email: event.email,
        phone: event.phone,
        address: event.address,
      );

      emit(StoreAccountUpdateSuccess());
    } on DioError catch (error) {
      final errorResponse = error.toGenericError();

      return emit(StoreAccountUpdateError(errorResponse));
    } catch (error) {
      debugPrint("error: $error");
      const errorResponse = GenericErrorResponse(
        errors: 'Something wrong',
        status: false,
        statusCode: 409,
      );

      return emit(const StoreAccountUpdateError(errorResponse));
    }
  }
}
