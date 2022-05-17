import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SinglePropertyDetailPage extends StatefulWidget {
  const SinglePropertyDetailPage({Key? key}) : super(key: key);

  @override
  State<SinglePropertyDetailPage> createState() =>
      _SinglePropertyDetailPageState();
}

class _SinglePropertyDetailPageState extends State<SinglePropertyDetailPage> {
  final img = [
    'assets/apart 0.jpg',
    'assets/apart 1.jpg',
    'assets/apart 2.jpg',
    'assets/apart 3.jpg',
    'assets/apart 4.jpg',
  ];
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffF9521E),
        onPressed: () {},
        child: Icon(Icons.phone),
      ),
      //appBar: AppBar(leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios)),),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: size.height * .55,
              width: size.width,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10.0, color: Colors.grey.withOpacity(0.5))
                ],
                //color: Colors.black54,
                borderRadius: BorderRadius.circular(25),
                // image: DecorationImage(
                //     image: AssetImage('assets/apart 3.jpg'),
                //     fit: BoxFit.cover)
              ),
              child: Stack(
                children: [
                  CarouselSlider.builder(
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
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: AnimatedSmoothIndicator(
                        count: img.length,
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
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              child: Container(
                height: size.height * .439,
                width: size.width,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Apartment for rent",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis),
                            ),
                            Row(
                              children: [
                                Text(
                                  "10,000",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                SizedBox(width: 5,),
                                Text(
                                  "SDG/Day",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(

                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              size: 17,
                              color: Colors.teal,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Khartoum, Gabra",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Amenities",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis),
                            ),
                            TextButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  //padding: MaterialStateProperty.all(EdgeInsets.all(50)),
                                  // textStyle: MaterialStateProperty.all(TextStyle(fontSize: 30))),
                                ),
                                child: Text(
                                  "View All",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      overflow: TextOverflow.ellipsis),
                                ))
                          ],
                        ),
                        SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Aminties(
                                title: '2 Bedrooms',
                                icon: Icons.hotel,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Aminties(
                                title: '1 Bathroom',
                                icon: Icons.bathtub,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Aminties(
                                  icon: Icons.zoom_out_map, title: "120 m"),
                              SizedBox(
                                width: 10,
                              ),
                              Aminties(
                                title: 'TV',
                                icon: Icons.tv_rounded,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Description",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "s simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Aminties extends StatelessWidget {
  const Aminties({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);
  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
        primary: Colors.white,
        backgroundColor: Color.fromRGBO(64, 75, 96, .9),
      ),
      onPressed: () {},
      child: Row(
        children: [
          Icon(
            icon,
            size: 17,
            //color:Colors.teal,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 15,
                //color: Colors.grey,
                overflow: TextOverflow.ellipsis),
          )
        ],
      ),
    );
  }
}

Widget buildImage(String imgs, int index) {
  return Container(
    width: double.infinity,
    height: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      image: DecorationImage(image: AssetImage(imgs), fit: BoxFit.cover),
    ),
  );
}
