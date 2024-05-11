import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkImageWidget extends StatelessWidget {
  final String imgUrl;
  final BoxFit boxFit;
  final double height;
  final double width;
  final bool onlyThumb;

  NetworkImageWidget({
    required this.imgUrl,
    this.boxFit = BoxFit.cover,
    this.height = 0,
    this.width = 0,
    this.onlyThumb = false,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: precacheImage(CachedNetworkImageProvider(imgUrl), context),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.hasError) {
            return _errorWidget();
          }
          return Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(imgUrl), fit: boxFit)),
              child:
                  snapshot.connectionState == ConnectionState.done && !onlyThumb
                      ? CachedNetworkImage(
                          imageUrl: imgUrl,
                          fit: boxFit,
                          errorWidget: (context, s, d) => _errorWidget(),
                        )
                      : null);
        });
  }

  Widget _errorWidget() {
    return Center(
      child: Icon(Icons.error),
    );
  }
}
