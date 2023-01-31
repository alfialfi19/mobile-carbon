import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../commons/commons.dart';
import '../../models/models.dart';
import '../../repositories/repositories.dart';

part 'attachment_event.dart';

part 'attachment_state.dart';

class AttachmentBloc extends Bloc<AttachmentEvent, AttachmentState> {
  final MediaRepository _mediaRepository;
  final bool isLocalDelete;

  AttachmentBloc(
    this._mediaRepository, {
    this.isLocalDelete = false,
  }) : super(BlobInitial()) {
    on<UploadAttachment>(_loadAttachmentHandler);
    on<DeleteAttachment>(_deleteAttachmentHandler);
  }

  Future<void> _loadAttachmentHandler(
    UploadAttachment event,
    Emitter<AttachmentState> emit,
  ) async {
    final filePath = event.filePath;

    try {
      final response = await _mediaRepository.create(event.filePath);

      emit(AttachmentUploaded(filePath, response));
    } on DioError catch (error) {
      final response = error.toGenericError();

      emit(AttachmentError(filePath, response.errors!));
    }
  }

  Future<void> _deleteAttachmentHandler(
    DeleteAttachment event,
    Emitter<AttachmentState> emit,
  ) async {
    if (!isLocalDelete) {
      _mediaRepository.deleteById(event.id);
    }

    emit(AttachmentDeleted(event.filePath));
  }
}
