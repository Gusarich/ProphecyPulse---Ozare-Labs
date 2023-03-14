import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ozare/features/dash/widgets/widgets.dart';

class LoadingSection extends StatelessWidget {
  const LoadingSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: 190,
      width: size.width,
      child: CarouselSlider.builder(
        itemCount: 3,
        options: CarouselOptions(
          height: 190,
          viewportFraction: 0.84,
          enableInfiniteScroll: false,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
        itemBuilder: (_, __, ___) => const LoadingMatchTile(),
      ),
    );
  }
}
