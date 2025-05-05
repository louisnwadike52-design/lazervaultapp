import 'package:flutter/material.dart';
import 'package:lazervault/src/features/widgets/universal_image_loader.dart';

class RoundedCenteredImage extends StatelessWidget {
  final double size;
  final Color backgroundColor;
  final String imagePath;
  final VoidCallback? onTap;

  const RoundedCenteredImage({
    super.key,
    required this.size,
    required this.backgroundColor,
    required this.imagePath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors
          .transparent, // Transparent to show background color of the container
      shape: CircleBorder(), // Ensure the ripple effect is circular
      child: InkWell(
        onTap: onTap, // Tap callback
        customBorder:
            CircleBorder(), // Ensures the ripple matches the circular shape
        splashColor: Colors.transparent, // Ripple effect color
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle, // Ensures the container is circular
          ),
          child: Center(
            child: ClipOval(
              child: UniversalImageLoader(
                imagePath: imagePath,
                width: size * 0.5, // Adjust the image size as needed
                height: size * 0.5,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
