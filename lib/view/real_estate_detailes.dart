import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hash/model/car_class.dart';
import 'package:after_layout/after_layout.dart';
import 'package:hash/model/real_estate_class.dart';

class PropertyInfo extends StatefulWidget {
  const PropertyInfo({Key? key, required this.property}) : super(key: key);
  final Property property;
  final double _expandBottomSheet = 0;
  final double _collapseBottomSheet = -645;
  final double _completelycollapsed = -690;

  @override
  _PropertyInfoState createState() => _PropertyInfoState();
}

class _PropertyInfoState extends State<PropertyInfo> with AfterLayoutMixin<PropertyInfo> {
  double _bottomSheetPosition = -690;
  bool _isCollapsed = false;
  final img = [
    'assets/house 0.jpg',
    'assets/house 1.jpg',
    'assets/house 2.jpg',
    'assets/house 3.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Hero(
            tag: widget.property.location,
            child: CarouselSlider.builder(
                itemCount: img.length,
                itemBuilder: (context, index, realIndex) {
                  final imgs = img[index];
                  return buildImage(imgs, index);
                },
                options: CarouselOptions(height: size.height,viewportFraction: 1, autoPlay: true )),
          ),
          Positioned(
            top: 20,
            left: 10,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 25.0,
              ),
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      _bottomSheetPosition = widget._completelycollapsed;
                    });
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 40,
                    color: Colors.deepOrange,
                  )),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.decelerate,
            left: 0,
            bottom: _bottomSheetPosition,
            right: 0,
            child: InkWell(
              onTap: () {
                setState(() {
                  _bottomSheetPosition = _isCollapsed
                      ? widget._expandBottomSheet
                      : widget._collapseBottomSheet;
                  _isCollapsed = !_isCollapsed;
                });
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.property.type,
                            style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black45),
                          ),
                          Text(
                            widget.property.offer,
                            style: const TextStyle(
                                color: Colors.deepOrange,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        height: size.height * .75,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Listing'),
                                Text(widget.property.listing),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Bedrooms'),
                                Text(widget.property.bedroom.toString()),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Bathroom'),
                                Text(widget.property.bathroom.toString()),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Halls'),
                                Text(widget.property.hall.toString()),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Kitchen'),
                                Text(widget.property.kitchen.toString()),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Space'),
                                Text("${widget.property.space.toString()} sq meter"),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Furnished'),
                                Text(widget.property.furnished),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('wifi'),
                                Text(widget.property.wifi),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Gym'),
                                Text(widget.property.gym),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Parking'),
                                Text(widget.property.parking),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Payment'),
                                Text(widget.property.payment),
                              ],
                            ),
                            const Divider(),
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 60,
                              child: const Text(
                                'Agency Info',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black45),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 Text(
                            widget.property.agency,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black45),
                                ),
                                Image.asset(
                                  'assets/car_seller.jpg',
                                  height: 50,
                                  width: 50,
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 60,
                              child:  Text(
                                'Location',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black45),
                              ),
                            ),
                            Row(
                              children:  [
                                Icon(Icons.map,
                                    size: 20, color: Colors.black45),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  widget.property.location,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black45),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 60,
                              child: const Text(
                                'Contacts',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black45),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                MaterialButton(
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
                                MaterialButton(
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
                                          "Message",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Cairo'),
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isCollapsed = true;
        _bottomSheetPosition = widget._collapseBottomSheet;
      });
    });
  }

  Widget buildImage(String imgs, int index) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imgs),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
