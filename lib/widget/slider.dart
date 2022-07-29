import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../model/property_ads_photos_model.dart';


class PhotoSlider extends StatefulWidget {
   PhotoSlider({Key? key, required this.images}) : super(key: key);
   List<PropertyAdsPhotos> images;
  @override
  State<PhotoSlider> createState() => _PhotoSliderState();
}

class _PhotoSliderState extends State<PhotoSlider> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        CarouselSlider.builder(
            itemCount: widget.images.length,
            itemBuilder: (context, index, realIndex) {
              final img = widget.images[index].photoName.toString();
              return buildImage(img, index);
            },
            options: CarouselOptions(
                height: double.infinity,
                viewportFraction: 1,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    var name = widget.images[index].photoName;
                    var imgIndex = widget.images.indexWhere((element) => element.photoName == name);
                    activeIndex = imgIndex;
                  });
                })),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: AnimatedSmoothIndicator(
              count: widget.images.length,
              activeIndex: activeIndex,
              effect: const ExpandingDotsEffect(
                dotHeight: 10,
                dotWidth: 10,
                activeDotColor: Color(0xffF9521E),
                dotColor: Colors.white,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50.0, left: 10),
          child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios, size: 25,), color: Color(0xffF9521E),)),
        )
      ],
    );
  }
}
Widget buildImage(String imgs, int index) {
  return Stack(
    children: [
      Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: AssetImage("assets/placeholder.png"),
                fit: BoxFit.fill)),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  blurRadius: 12.0,
                  color: Colors.grey.withOpacity(0.5))
            ],
          ),
          child: FadeInImage.assetNetwork(
            fit: BoxFit.fill,
            image: "http://192.168.15.124/easy/image/${imgs}",
            placeholder: "assets/placeholder.png",
          ),
        ),
      ),

    ],
  );
}