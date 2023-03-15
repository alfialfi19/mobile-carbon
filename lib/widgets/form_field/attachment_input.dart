import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';
import '../../commons/commons.dart';
import '../../models/models.dart';
import '../../repositories/repositories.dart';
import '../widgets.dart';

typedef OnChangedAttachment = void Function(List<String>);
typedef OnAddAttachment = void Function(String);

class AttachmentInput extends StatelessWidget {
  final String? formzError;
  final OnChangedAttachment callback;
  final OnAddAttachment onAddCallback;
  final List<MediaSet>? mediaSet;
  final bool isLocalDelete;

  const AttachmentInput({
    required this.callback,
    required this.onAddCallback,
    this.formzError,
    this.mediaSet,
    this.isLocalDelete = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AttachmentBloc>(
      create: (context) {
        final repository = RepositoryProvider.of<MediaRepository>(context);

        return AttachmentBloc(
          repository,
          isLocalDelete: isLocalDelete,
        );
      },
      child: _AttachmentInputContent(
        formzError: formzError,
        callback: callback,
        onAddCallback: onAddCallback,
        mediaSet: mediaSet,
      ),
    );
  }
}

class _AttachmentInputContent extends StatefulWidget {
  final String? formzError;
  final OnChangedAttachment callback;
  final OnAddAttachment onAddCallback;
  final List<MediaSet>? mediaSet;

  const _AttachmentInputContent({
    required this.callback,
    required this.onAddCallback,
    this.formzError,
    this.mediaSet,
  });

  @override
  State<_AttachmentInputContent> createState() =>
      _AttachmentInputContentState();
}

class _AttachmentInputContentState extends State<_AttachmentInputContent> {
  static const _maxFile = 5;
  static const _maxSize = 5;
  static const _maxImageHeightWidth = 1080.0;
  static const _fileExtensions = [
    FileExtensions.jpg,
    FileExtensions.jpeg,
    FileExtensions.png,
    FileExtensions.bmp,
    FileExtensions.pdf,
  ];
  final List<File> _currentFile = [];

  final _attachments = <String, String>{};
  final errorAttachmentCode = '-1';
  late StreamSubscription _attachmentBlocSubscription;

  bool _isLoadingCurrentFile = false;

  @override
  void initState() {
    // _attachmentBlocSubscription = BlocProvider.of<AttachmentBloc>(context)
    //     .stream
    //     .listen(_attachmentBlocListener);

    if (widget.mediaSet != null && widget.mediaSet!.isNotEmpty) {
      setState(() {
        _isLoadingCurrentFile = true;
      });

      _convertReceiptToFile(widget.mediaSet);
    }

    super.initState();
  }

  void _attachmentBlocListener(AttachmentState state) {
    if (state is AttachmentUploaded) {
      _onAttachmentUploaded(state);
    } else if (state is AttachmentError) {
      _onAttachmentError(state);
    }
  }

  Future<void> _convertReceiptToFile(List<MediaSet>? receipt) async {
    for (final data in receipt!) {
      final tempFile = await getFileFromUrl(data.media!.url!);

      _currentFile.add(tempFile);

      setState(() {
        _attachments[tempFile.path] = data.media!.id!;
      });
      _onAttachmentChanged();
    }

    setState(() {
      _isLoadingCurrentFile = false;
    });
  }

  @override
  void dispose() {
    _attachmentBlocSubscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Gambar",
            style: Theme.of(context).textTheme.caption?.copyWith(
                  color: ColorPalettes.dark,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(
            height: 16.9,
          ),
          if (widget.mediaSet != null && _isLoadingCurrentFile)
            Container(
              height: 80,
              width: 80,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                color: ColorPalettes.primary,
              ),
            )
          else
            FilePickerFormField(
              initialValue: _currentFile,
              maxAttachment: _maxFile,
              maxFileSize: _maxSize,
              maxImageHeightWidth: _maxImageHeightWidth,
              hideSelectorOnMaxAttachment: false,
              onShowThumbnail: _buildAttachmentThumbnail,
              allowMultiple: true,
              onAttachmentAdded: _onAttachmentAdded,
              onAttachmentRemoved: _onAttachmentRemoved,
              placeholderHeight: 100.0,
              allowedExtensions: _fileExtensions,
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorPalettes.backgroundLight),
                ),
              ),
              formzError: widget.formzError,
            ),
          // const SizedBox(
          //   height: 4.0,
          // ),
          // Align(
          //   alignment: Alignment.centerLeft,
          //   child: Text(
          //     "Files must be in JPG, JPEG, PNG, or PDF with a maximum size of ${_maxSize.toStringAsFixed(0)}MB. You can upload up to ${_maxFile.toStringAsFixed(0)} files at once.",
          //     style: Theme.of(context).textTheme.overline!.copyWith(
          //           color: ColorPalettes.grayZill,
          //         ),
          //   ),
          // ),
        ],
      ),
    );
  }

  List<FileThumbnail> _buildAttachmentThumbnail(List<File> files) {
    return _attachments.keys.map((filePath) {
      final value = _attachments[filePath];
      // final status = value.isBlank
      //     ? AttachmentStatus.loading
      //     : value == errorAttachmentCode
      //         ? AttachmentStatus.error
      //         : AttachmentStatus.added;
      const status = AttachmentStatus.added;
      final thumbnail = AttachmentThumbnail(
        key: ValueKey(filePath),
        filePath: filePath,
        status: status,
      );
      final showClearButton = _attachments[filePath].isNotBlank;

      return FileThumbnail(
        thumbnail,
        showClearButton: showClearButton,
      );
    }).toList();
  }

  // Actions
  void _onAttachmentUploaded(AttachmentUploaded state) {
    if (state.blob.id != null) {
      setState(() {
        _attachments[state.filePath] = state.blob.id!;
      });

      _onAttachmentChanged();
    }
  }

  void _onAttachmentError(AttachmentError state) {
    setState(() {
      _attachments[state.filePath] = errorAttachmentCode;
    });
  }

  void _onAttachmentAdded(File file) {
    final filePath = file.path;
    // BlocProvider.of<AttachmentBloc>(context).add(UploadAttachment(filePath));

    setState(() {
      _attachments[filePath] = '';
    });

    _onAttachmentChanged();

    widget.onAddCallback.call(filePath);
  }

  void _onAttachmentRemoved(int index, File file) {
    final filePath = file.path;
    final fileId = _attachments[filePath];
    // if (fileId.isNotBlank && fileId != errorAttachmentCode) {
    //   BlocProvider.of<AttachmentBloc>(context)
    //       .add(DeleteAttachment(filePath, fileId!));
    // }

    setState(() {
      _attachments.remove(filePath);
    });

    _onAttachmentChanged();
  }

  void _onAttachmentChanged() {
    print("====> _attachments: $_attachments");
    final attachmentIds = _attachments.values
        .where((value) => value != errorAttachmentCode)
        .toList();

    widget.callback.call(attachmentIds);
  }
}
