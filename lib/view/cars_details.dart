import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hash/model/car_class.dart';
import 'package:after_layout/after_layout.dart';

class CarsInfo extends StatefulWidget {
  const CarsInfo({Key? key, required this.cars}) : super(key: key);
  final Cars cars;
  final double _expandBottomSheet = 0;
  final double _collapseBottomSheet = -645;
  final double _completelycollapsed = -690;

  @override
  _CarsInfoState createState() => _CarsInfoState();
}

class _CarsInfoState extends State<CarsInfo> with AfterLayoutMixin<CarsInfo> {
  double _bottomSheetPosition = -690;
  bool _isCollapsed = false;
  final img = [
    'assets/car 0.jpg',
    'assets/car 1.jpg',
    'assets/car 2.jpg',
    'assets/car 3.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Hero(
            tag: widget.cars.name,
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
                            widget.cars.name,
                            style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black45),
                          ),
                          Text(
                            widget.cars.offer,
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
                                const Text('Condition'),
                                Text(widget.cars.condition),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Color'),
                                Text(widget.cars.color),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Model'),
                                Text(widget.cars.model.toString()),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Doors'),
                                Text(widget.cars.doors.toString()),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Kilometers'),
                                Text(widget.cars.kilometer.toString()),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Type'),
                                Text(widget.cars.type),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('No. of Cylinders'),
                                Text(widget.cars.cylinders.toString()),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Transmission Type'),
                                Text(widget.cars.transmission),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('fuel Type'),
                                Text(widget.cars.fuel),
                              ],
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 80,
                              child: const Text(
                                'Dealer Info',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black45),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Car Deal Car Selling Inc.',
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
                              height: 80,
                              child: const Text(
                                'Locaion',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black45),
                              ),
                            ),
                            Row(
                              children: const [
                                Icon(Icons.map,
                                    size: 30, color: Colors.black45),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '60th st. Khartoum',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black45),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 80,
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
