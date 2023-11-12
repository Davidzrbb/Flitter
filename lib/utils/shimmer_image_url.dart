import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerImageUrl extends StatelessWidget {
  const ShimmerImageUrl({
    super.key,
    required this.url,
    required this.width,
    required this.height,
  });

  final String url;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return _shimmerImageUrl(url, context);
  }

  _shimmerImageUrl(String url, BuildContext context) {
    return GestureDetector(
        onTap: () {
          _showImageDialog(context, url);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: CachedNetworkImage(
            height: height,
            width: width,
            imageUrl: url,
            fit: BoxFit.cover,
            placeholder: (context, url) {
              return SizedBox(
                height: height,
                width: width,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    color: Colors.white,
                  ),
                ),
              );
            },
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ));
  }

  void _showImageDialog(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        );
      },
    );
  }
}
