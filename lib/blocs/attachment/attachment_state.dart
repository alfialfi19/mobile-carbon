part of 'attachment_bloc.dart';

abstract class AttachmentState extends Equatable {}

class BlobInitial extends AttachmentState {
  @override
  List<Object?> get props => [];
}

class AttachmentUploaded extends AttachmentState {
  final String filePath;
  final Blob blob;

  AttachmentUploaded(
    this.filePath,
    this.blob,
  );

  @override
  List<Object> get props => [
        filePath,
        blob,
      ];
}

class AttachmentError extends AttachmentState {
  final String filePath;
  final String errorMessage;

  AttachmentError(this.filePath, this.errorMessage);

  @override
  List<Object> get props => [filePath, errorMessage];
}

class AttachmentDeleted extends AttachmentState {
  final String filePath;

  AttachmentDeleted(this.filePath);

  @override
  List<Object> get props => [filePath];
}
