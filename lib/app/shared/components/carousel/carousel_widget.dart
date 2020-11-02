import 'package:fazentech/app/shared/components/carousel/carousel_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';

class CarouselWidget extends StatefulWidget {
  final List<String> images;
  CarouselWidget({
    Key key,
    @required this.images
  }) : super(key: key);

  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {

  final pageController = PageController();

  bool _isIndicatorActive(int index) {
    int page = pageController?.page?.round() ?? 0;
    return page == index;
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.images;

    return AspectRatio(
      aspectRatio: 1.3,
      child: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (page) => setState((){}),
            children: List.generate(
              images.length,
              (index) => OctoImage(
                image: NetworkImage(images[index]),
                fit: BoxFit.cover
              )
            )
          ),
          IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black26],
                  stops: [0.6, 1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
                )
              ),
            ),
          ),
          Builder(
            builder: (context) {
              return Container(
                margin: const EdgeInsets.only(bottom: 8.0),
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    images.length,
                    (index) => CarouselIndicatorWidget(
                      isActive: _isIndicatorActive(index),
                    )
                  ),
                )
              );
            }
          )
        ]
      ),
    );
  }
}