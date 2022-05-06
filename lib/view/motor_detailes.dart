import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../model/car_class.dart';
import '../widget/car_ name_price.dart';
import 'package:photo_view/photo_view.dart';

class MotorDetailes extends StatefulWidget {
  const MotorDetailes({Key? key, required this.cars}) : super(key: key);
  final Cars cars;
  @override
  State<MotorDetailes> createState() => _MotorDetailesState();
}

class _MotorDetailesState extends State<MotorDetailes> {
  final img = [
    'assets/car 0.jpg',
    'assets/car 1.jpg',
    'assets/car 2.jpg',
    'assets/car 3.jpg',
    'assets/real_car.jpg',
  ];
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: size.height * .33,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromRGBO(64, 75, 96, .9).withOpacity(0.7),
                ),
                child: CarouselSlider.builder(
                    itemCount: img.length,
                    itemBuilder: (context, index, realIndex) {
                      final imgs = img[index];
                      return buildImage(imgs, index);
                    },
                    options: CarouselOptions(
                        height: size.height,
                        viewportFraction: 1,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            activeIndex = index;
                          });
                        })),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            AnimatedSmoothIndicator(
              count: img.length,
              activeIndex: activeIndex,
              effect: const ExpandingDotsEffect(
                dotHeight: 10,
                dotWidth: 10,
                activeDotColor: Colors.deepOrangeAccent,
                dotColor: Colors.black12,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
             VehicleNamePrice(
              price: widget.cars.offer,
              title: widget.cars.name,
            ),
            const SizedBox(
              height: 10,
            ),

            Container(
              width: size.width,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(64, 75, 96, .9),
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DetailesRow(type: widget.cars.model.toString(), title: "model".tr(),),
                    Divider(color: Colors.deepOrange.shade200),
                    DetailesRow(type: widget.cars.condition, title: "condition".tr(),),
                    Divider(color: Colors.deepOrange.shade200),
                    DetailesRow(type: widget.cars.color, title: "Color".tr(),),
                    Divider(color: Colors.deepOrange.shade200),
                    DetailesRow(type: widget.cars.type, title: "car_type".tr(),),
                    Divider(color: Colors.deepOrange.shade200),
                    DetailesRow(type: widget.cars.doors.toString(), title: "doors".tr(),),
                    Divider(color: Colors.deepOrange.shade200),
                    DetailesRow(type: widget.cars.transmission, title: "Trans".tr(),),
                    Divider(color: Colors.deepOrange.shade200),
                    DetailesRow(type: widget.cars.fuel, title: "fuel".tr(),),
                    Divider(color: Colors.deepOrange.shade200),
                    DetailesRow(type: widget.cars.kilometer.toString(), title: "kilos".tr(),),
                    Divider(color: Colors.deepOrange.shade200),
                    DetailesRow(type: widget.cars.cylinders.toString(), title: "cylinders".tr(),),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: size.width,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(64, 75, 96, .9),
                  borderRadius: BorderRadius.circular(30)),
              child:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Text(
                      widget.cars.seller,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    CircleAvatar(
                      backgroundImage: AssetImage(widget.cars.sellerLogo),
                      radius: 30,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: size.width,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(64, 75, 96, .9),
                  borderRadius: BorderRadius.circular(30)),
              child:  Padding(
                padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.pin_drop_rounded, color: Colors.deepOrangeAccent.shade200,),
                    const SizedBox(width: 10,),
                    Text(
                        widget.cars.location,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),

                    const Spacer(),
                    Icon(Icons.map_rounded, color: Colors.deepOrangeAccent.shade200,),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 30),
              child: MaterialButton(
                  onPressed: () {},
                  elevation: 5,
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(28)),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Call",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo'),
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  buildIndicator() {
    AnimatedSmoothIndicator(
      count: img.length,
      activeIndex: activeIndex,
      effect: const ExpandingDotsEffect(
        activeDotColor: Colors.deepOrangeAccent,
        dotColor: Colors.black12,
      ),
    );
  }
}

class DetailesRow extends StatelessWidget {
  const DetailesRow({
    Key? key,
    required this.type, required this.title,
  }) : super(key: key);

  final String type;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children:  [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold
          ),
        ),
        const Spacer(),
        Text(
            type,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}

Widget buildImage(String imgs, int index) {
  return Padding(
    padding: const EdgeInsets.all(7.0),
    child: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(imgs),
          fit: BoxFit.fill
        ),
      ),
    ),
  );
}
