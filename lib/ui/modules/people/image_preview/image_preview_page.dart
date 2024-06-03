import 'package:axis_assignment/bloc/people/images/save_image/bloc.dart';
import 'package:axis_assignment/data/models/person_image.dart';
import 'package:axis_assignment/ui/common/loading_widget.dart';
import 'package:axis_assignment/utils/constants.dart';
import 'package:axis_assignment/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImagePreviewPage extends StatefulWidget {
  final PersonImage image;

  const ImagePreviewPage({super.key, required this.image});

  @override
  State<ImagePreviewPage> createState() => _ImagePreviewPageState();
}

class _ImagePreviewPageState extends State<ImagePreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF343434),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          BlocConsumer<SaveImageBloc, SaveImageState>(
            listener: (context, state) {
              if (state is ErrorSaveImageState) {
                Utils.showToast(message: state.message, state: SnackBarStates.ERROR);
              } else if (state is SuccessSaveImageState) {
                Utils.showToast(message: "Saved to gallery", state: SnackBarStates.SUCCESS);
              }
            },
            builder: (context, state) {
              if (state is LoadingSaveImageState) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }
              return IconButton(
                icon: const Icon(Icons.download, color: Colors.white),
                onPressed: () => BlocProvider.of<SaveImageBloc>(context, listen: false)
                    .add(SaveImage('${Constants.imagesBaseUrl}/${widget.image.filePath}')),
              );
            },
          ),
        ],
        // theme: Theme.of(context),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: PhotoViewGallery.builder(
            scrollPhysics: const ClampingScrollPhysics(),
            backgroundDecoration: const BoxDecoration(color: Color(0xFF343434)),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: CachedNetworkImageProvider('${Constants.imagesBaseUrl}/${widget.image.filePath}'),
                initialScale: PhotoViewComputedScale.contained,
                minScale: 0.5,
                maxScale: 1.0,
                heroAttributes: PhotoViewHeroAttributes(tag: widget.image.filePath),
              );
            },
            itemCount: 1,
            loadingBuilder: (context, event) => const LoadingWidget(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
