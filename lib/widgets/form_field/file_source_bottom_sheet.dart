import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../commons/commons.dart';
import '../widgets.dart';

typedef OnPickImage = Future<void> Function(ImageSource)?;

typedef OnPickFile = Future<void> Function()?;

class FileSourceBottomSheet extends StatelessWidget {
  final bool enablePickImage;
  final OnPickImage onPickImage;
  final OnPickFile onPickFile;
  final List<String> allowedExtensions;

  const FileSourceBottomSheet({
    required this.enablePickImage,
    required this.allowedExtensions,
    this.onPickImage,
    this.onPickFile,
    super.key,
  })  : assert(!enablePickImage || onPickImage != null),
        assert(allowedExtensions.length != 0 || onPickFile != null);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Wrap(
        children: [
          BottomSheetContainer(
            color: ColorPalettes.cloud,
            header: BottomSheetTitleHeader(
              titleText: "Add attachment",
              closeDialogText: "Close",
            ),
            content: Container(
              color: ColorPalettes.white,
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (enablePickImage)
                    _FileSourceOptionTile(
                      label: "Camera",
                      onTap: () => onPickImage!(ImageSource.camera),
                    ),
                  if (enablePickImage && Platform.isIOS)
                    _FileSourceOptionTile(
                      label: "Gallery",
                      onTap: () => onPickImage!(ImageSource.gallery),
                    ),
                  if (allowedExtensions.isNotNullOrEmpty)
                    _FileSourceOptionTile(
                      label: "File",
                      onTap: onPickFile,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FileSourceOptionTile extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const _FileSourceOptionTile({
    required this.label,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        onTap?.call();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          const Divider(
            height: 1.0,
            indent: 16.0,
            thickness: 1.0,
          )
        ],
      ),
    );
  }
}
