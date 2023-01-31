import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../blocs/blocs.dart';
import '../../commons/commons.dart';

enum AttachmentStatus { added, loading, error }

class AttachmentThumbnail extends StatefulWidget {
  final String filePath;
  final AttachmentStatus status;

  const AttachmentThumbnail({
    required this.filePath,
    this.status = AttachmentStatus.loading,
    ValueKey? key,
  }) : super(key: key);

  @override
  _AttachmentThumbnailState createState() => _AttachmentThumbnailState();
}

class _AttachmentThumbnailState extends State<AttachmentThumbnail> {
  var _status = AttachmentStatus.loading;

  late StreamSubscription _attachmentBlocSubscription;

  String get fileExtension => getFileExtension(widget.filePath).toLowerCase();

  @override
  void initState() {
    super.initState();

    _attachmentBlocSubscription = BlocProvider.of<AttachmentBloc>(context)
        .stream
        .listen(_attachmentBlocListener);

    _status = widget.status;
  }

  void _attachmentBlocListener(AttachmentState state) {
    if (state is AttachmentUploaded) {
      _onUploaded(state.filePath);
    } else if (state is AttachmentError) {
      _onError(state.filePath);
    }
  }

  void _onUploaded(String filePath) {
    if (filePath == widget.filePath) {
      setState(() {
        _status = AttachmentStatus.added;
      });
    }
  }

  void _onError(String filePath) {
    if (filePath == widget.filePath) {
      setState(() {
        _status = AttachmentStatus.error;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();

    _attachmentBlocSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: _buildThumbnail(),
      ),
    );
  }

  Widget _buildThumbnail() {
    if (_status == AttachmentStatus.added) {
      return _buildThumbnailImage();
    }

    final foreground = _status == AttachmentStatus.error
        ? _buildErrorIcon()
        : _buildCircularLoading();

    return Stack(
      alignment: Alignment.center,
      children: [
        _buildThumbnailImage(),
        Positioned.fill(
          child: ColoredBox(
            color: ColorPalettes.dark.withAlpha(204),
          ),
        ),
        foreground
      ],
    );
  }

  Widget _buildThumbnailImage() {
    if (imageFileExtensions.contains(fileExtension)) {
      return Image.file(
        File(widget.filePath),
        fit: BoxFit.cover,
        height: 160.0,
        width: 120.0,
      );
    }

    return Container(
      height: 160.0,
      width: 120.0,
      alignment: Alignment.center,
      color: ColorPalettes.smoke,
      child: _iconData(),
    );
  }

  Widget _iconData() {
    String asset;
    switch (fileExtension) {
      case FileExtensions.pdf:
        asset = CarbonIcons.article;
        break;
      default:
        asset = CarbonIcons.article;
    }

    return SvgPicture.asset(
      asset,
      height: 84.0,
    );
  }

  Widget _buildErrorIcon() {
    return SvgPicture.asset(
      Images.error,
      height: 48.0,
      width: 48.0,
    );
  }

  Widget _buildCircularLoading() {
    return const SizedBox(
      height: 48.0,
      width: 48.0,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(ColorPalettes.successDark),
        backgroundColor: ColorPalettes.successLight,
      ),
    );
  }
}
