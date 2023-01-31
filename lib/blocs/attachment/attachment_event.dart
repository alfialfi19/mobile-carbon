part of 'attachment_bloc.dart';

abstract class AttachmentEvent extends Equatable {}

class UploadAttachment extends AttachmentEvent {
  final String filePath;

  UploadAttachment(this.filePath);

  @override
  List<Object> get props => [filePath];
}

class DeleteAttachment extends AttachmentEvent {
  final String filePath;
  final String id;

  DeleteAttachment(this.filePath, this.id);

  @override
  List<Object> get props => [filePath, id];
}
