import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'loading_widget.dart';

class CustomCachedImage extends StatelessWidget {
  const CustomCachedImage({
    required this.image,
    this.height = 60,
    this.width = 75,
    this.hasOverlay = false,
    this.cornerRadius = 10,
    super.key,
  });

  final String image;
  final double height;
  final double width;
  final double cornerRadius;
  final bool hasOverlay;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(cornerRadius),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            colorFilter: hasOverlay ? ColorFilter.mode(Colors.black.withOpacity(0.1), BlendMode.darken) : null,
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        width: width,
        height: height,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(cornerRadius),
        ),
        child: Center(child: LoadingWidget(color: Colors.white, size: height)),
      ),

      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(4),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(cornerRadius),
        ),
        child: SvgPicture.asset(
          'assets/icons/image.svg',
          fit: BoxFit.contain,
          color: Theme.of(context).colorScheme.onTertiary,
        ),
      ),
    );
  }
}
