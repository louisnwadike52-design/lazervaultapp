import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lazervault/core/data/app_data.dart';

class ImageLoader {
  static ImageProvider<Object> view({
    required String uri,
    String fallbackImgUri = AppData.defaultAvatar,
  }) {
    uri = uri.isEmpty ? fallbackImgUri : uri;
    final isNetwork = uri.startsWith('http://') || uri.startsWith('https://');

    if (isNetwork) {
      return CachedNetworkImageProvider(uri);
    } else {
      return AssetImage(uri);
    }
  }
}
