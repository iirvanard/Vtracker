import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget(
      {super.key,
      this.fit = BoxFit.fill,
      this.width = 45,
      this.height = 40,
      this.borderRadius = 3,
      this.imageUrl});
  final String? imageUrl;
  final BoxFit fit;
  final double width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius.r),
      child: imageUrl == null
          ? Image.asset(
              'assets/placeholder.png',
              width: width.w,
              height: height.h,
              fit: fit,
            )
          : CachedNetworkImage(
              imageUrl: imageUrl!,
              width: width.w,
              height: height.h,
              filterQuality: FilterQuality.low,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: fit,
                  ),
                ),
              ),
            ),
    );
  }
}
