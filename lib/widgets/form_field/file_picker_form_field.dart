import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heic_to_jpg/heic_to_jpg.dart';
import 'package:image_picker/image_picker.dart';

import '../../commons/commons.dart';
import '../widgets.dart';

typedef OnAttachmentAdded = void Function(File);

typedef OnAttachmentRemoved = void Function(int, File);

typedef OnShowThumbnail = List<FileThumbnail> Function(List<File>);

class FilePickerFormField extends FormField<List<File>> {
  final ValueChanged<List<File>?>? onChanged;
  final int maxAttachment;
  final int maxFileSize; // in MB
  final double maxImageHeightWidth;
  final OnShowThumbnail onShowThumbnail;
  final OnAttachmentAdded onAttachmentAdded;
  final OnAttachmentRemoved onAttachmentRemoved;
  final List<String> allowedExtensions;
  final bool enablePickImage;
  final bool allowMultiple;
  final InputDecoration? decoration;
  final bool hideSelectorOnMaxAttachment;
  final String? formzError;

  FilePickerFormField({
    required this.maxAttachment,
    required this.maxFileSize,
    required this.maxImageHeightWidth,
    required this.onShowThumbnail,
    required this.onAttachmentAdded,
    required this.onAttachmentRemoved,
    required this.allowedExtensions,
    required this.hideSelectorOnMaxAttachment,
    required double placeholderHeight,
    List<File>? initialValue,
    super.validator,
    super.onSaved,
    Axis scrollDirection = Axis.horizontal,
    this.decoration,
    this.enablePickImage = true,
    this.allowMultiple = false,
    this.onChanged,
    this.formzError,
  }) : super(
          initialValue: initialValue ?? [],
          builder: (field) {
            final state = field as _FilePickerFormFieldState;
            final effectiveDecoration = (decoration ?? const InputDecoration())
                .applyDefaults(Theme.of(field.context).inputDecorationTheme)
                .copyWith(
                  errorText: state.errorMessage,
                  errorStyle: const TextStyle(height: 1),
                  errorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 0.0,
                    ),
                  ),
                  isDense: true,
                  contentPadding: const EdgeInsets.all(0.0),
                );
            final thumbnails = state._constructThumbnails();
            final isAddable = state.remainingItems > 0;
            final itemCount = isAddable || !hideSelectorOnMaxAttachment
                ? state.totalAddedFile + 1
                : maxAttachment;

            return InputDecorator(
              decoration: effectiveDecoration,
              child: SizedBox(
                height: placeholderHeight,
                child: ListView.builder(
                  scrollDirection: scrollDirection,
                  itemBuilder: (context, index) {
                    if (index == 0 &&
                        (isAddable || !hideSelectorOnMaxAttachment)) {
                      return state._buildSelector(enabled: isAddable);
                    }

                    final fileIndex = isAddable || !hideSelectorOnMaxAttachment
                        ? index - 1
                        : index;
                    return thumbnails[fileIndex];
                  },
                  itemCount: itemCount,
                ),
              ),
            );
          },
        );

  @override
  _FilePickerFormFieldState createState() => _FilePickerFormFieldState();
}

class _FilePickerFormFieldState extends FormFieldState<List<File>> {
  final _picker = ImagePicker();
  late List<File> _files;
  String? _errorMessage;

  ValueKey selectorKey = const ValueKey('selector_key');

  @override
  FilePickerFormField get widget => super.widget as FilePickerFormField;

  int get totalAddedFile => _files.length;

  int get remainingItems => widget.maxAttachment - totalAddedFile;

  // 1 MB = 1024*1024*1 B or 1,048,576 Bytes
  int get maxFileSizeInBytes => widget.maxFileSize * 1024 * 1024;

  String? get errorMessage =>
      _errorMessage.isNotBlank ? _errorMessage : widget.formzError;

  List<String> get fileNames => _files.map((file) => file.path).toList();

  @override
  void initState() {
    super.initState();
    _files = widget.initialValue ?? [];
  }

  Widget _buildSelector({bool enabled = true}) {
    return InkWell(
      onTap: () {
        final currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild!.unfocus();
        }

        if (enabled) {
          _showFileSelectorBottomSheet();
        } else {
          _showToastMessage(
            "The maximum file attached is 5",
          );
        }
      },
      child: _buildAttachmentSelector(),
    );
  }

  Widget _buildAttachmentSelector() {
    // 16.0 is for horizontal margins
    final maxWidth = screenWidth(context) - 16.0;

    return SizedBox(
      key: selectorKey,
      width: 120.0,
      child: AttachmentSelector(
        primaryPlaceholder: "Add file",
        isErrorState: errorMessage.isNotBlank,
      ),
    );
  }

  List<Widget> _constructThumbnails() {
    final fileThumbnails = widget.onShowThumbnail(_files);
    final result = <Widget>[];
    for (var index = 0; index < fileThumbnails.length; index++) {
      final thumbnail = Stack(
        // alignment: Alignment.topRight,
        children: [
          fileThumbnails[index].thumbnail,
          if (fileThumbnails[index].showClearButton)
            Positioned(
              right: 0.0,
              top: 0.0,
              child: GestureDetector(
                onTap: () => _removeFileAtIndex(index),
                child: Container(
                  padding: const EdgeInsets.all(7.4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: ColorPalettes.redConfirmation,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: ColorPalettes.white,
                    size: 20.0,
                  ),
                ),
              ),
            ),
        ],
      );
      result.add(thumbnail);
    }

    return result;
  }

  // Actions
  void _showToastMessage(String message) {
    ToastUtil.info(context, message);
  }

  Future<void> _showFileSelectorBottomSheet() {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: defaultBottomSheetShape,
      builder: (context) => FileSourceBottomSheet(
        enablePickImage: widget.enablePickImage,
        onPickImage: _onPickImage,
        onPickFile: _onPickFiles,
        allowedExtensions: widget.allowedExtensions,
      ),
    );
  }

  Future<void> _onPickImage(ImageSource source) async {
    XFile? pickedFile;

    if (Platform.isIOS) {
      try {
        pickedFile = await _picker.pickImage(
          source: source,
          maxHeight: widget.maxImageHeightWidth,
          maxWidth: widget.maxImageHeightWidth,
        );
      } on PlatformException catch (err) {
        final code = err.code;

        if (code == ErrorCodePermission.photosDenied) {
          _showToastMessage(
            "Please allow your photos permission",
          );
        } else if (code == ErrorCodePermission.cameraDenied) {
          _showToastMessage(
            "Please allow your camera permission",
          );
        } else {
          _showToastMessage(
            "Terjadi kesalahan, silahkan coba lagi nanti",
          );
        }
      }
    } else {
      try {
        pickedFile = await _picker.pickImage(
          source: source,
          maxHeight: widget.maxImageHeightWidth,
          maxWidth: widget.maxImageHeightWidth,
        );
      } on PlatformException catch (err) {
        final code = err.code;

        if (code == ErrorCodePermission.cameraDenied) {
          _showToastMessage(
            "Please allow your camera permission",
          );
        } else {
          _showToastMessage(
            "Terjadi kesalahan, silahkan coba lagi nanti",
          );
        }
      }
    }

    if (!mounted) {
      return;
    }

    if (pickedFile != null) {
      final path = await _convertToJpgIfHeic(pickedFile.path);

      if (path != null) {
        final file = File(path);
        await _addFile([file]);
      } else {
        ToastUtil.error(
          context,
          "Terjadi kesalahan, silahkan coba lagi nanti",
        );
      }
    }
  }

  Future<String?> _convertToJpgIfHeic(String filePath) async {
    final fileExtension = getFileExtension(filePath);
    if (fileExtension == FileExtensions.heic) {
      return HeicToJpg.convert(filePath);
    }

    return filePath;
  }

  Future<void> _addFile(List<File> fileList) async {
    for (final file in fileList) {
      if (remainingItems == 0) {
        _showToastMessage(
          "The maximum file attached is 5",
        );
        break;
      }
      final validate = await _validate(file);
      final containDuplicate = _containDuplicate(_files, file);
      if (!containDuplicate && validate) {
        setState(() {
          _errorMessage = null;
          _files.add(file);
        });

        didChange(_files);
        widget.onAttachmentAdded(file);
        widget.onChanged?.call(_files);
      }
    }
  }

  bool _containDuplicate(List<File> files, File file) {
    return files.any((f) => f.path == file.path);
  }

  Future<bool> _validate(File file) async {
    final fileSize = await file.length();
    if (fileSize > maxFileSizeInBytes) {
      setState(() {
        _errorMessage = "Please attach file below 5 MB";
      });

      return false;
    }

    return true;
  }

  Future<void> _onPickFiles() async {
    FilePickerResult? pickedFile;

    try {
      pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: widget.allowedExtensions,
        allowMultiple: widget.allowMultiple,
      );
    } on PlatformException catch (err) {
      final code = err.code;

      if (code == ErrorCodePermission.storageDenied) {
        _showToastMessage(
          "Please allow your storage permission",
        );
      } else {
        _showToastMessage(
          "Terjadi kesalahan, silahkan coba lagi nanti",
        );
      }
    }

    if (!mounted) {
      return;
    }

    if (pickedFile != null) {
      final platformFiles = pickedFile.files;
      final files = platformFiles
          .where((value) => value.path != null)
          .map((value) => File(value.path!))
          .toList();
      await _addFile(files);
    }
  }

  void _removeFileAtIndex(int index) {
    final file = _files[index];
    setState(() {
      _errorMessage = null;
      _files.removeAt(index);
    });

    didChange(_files);
    widget.onAttachmentRemoved(index, file);
    widget.onChanged?.call(_files);
  }
}

class FileThumbnail {
  final Widget thumbnail;
  final bool showClearButton;

  FileThumbnail(this.thumbnail, {this.showClearButton = true});
}
