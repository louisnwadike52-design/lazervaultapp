import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UniversalImageLoader extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit fit;

  const UniversalImageLoader({
    super.key,
    required this.imagePath,
    this.fit = BoxFit.contain,
    this.width,
    this.height,
  });

  bool _isNetworkImage(String path) {
    return Uri.tryParse(path)?.hasAbsolutePath ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return _isNetworkImage(imagePath)
        ? CachedNetworkImage(
            imageUrl: imagePath,
            fit: fit,
            imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).dialogBackgroundColor,
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: fit,
                    ),
                  ),
                ),
            placeholder: (context, url) => Container(),
            errorWidget: (context, url, error) =>
                const Icon(Icons.error_outline))
        : Image.asset(
            imagePath,
            width: width,
            height: height,
            fit: fit,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.error_outline),
          );
  }
}
