import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hash/view/home_body.dart';
import '../upload/upload_property.dart';
import '../view/contact_us.dart';
import '../view/notifications_page.dart';
import '../view/settings.dart';
import 'dart:math' as math;
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';


class BottomHomeScreen extends StatefulWidget {
  const BottomHomeScreen({Key? key}) : super(key: key);

  @override
  _BottomHomeScreenState createState() => _BottomHomeScreenState();
}

class _BottomHomeScreenState extends State<BottomHomeScreen> {
   int _selectedIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  final List<Widget> _screen = [
    HomeBody(),
    Notifications(),
    ContactUs(),
    Settings(),
  ];
  final iconList = <IconData>[
    Icons.home_rounded,
    Icons.history_rounded,
    Icons.search_rounded,
    Icons.person,
  ];
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onTapped(int selectedIndex ) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    bool isRtl = Directionality.of(context).index == 0;
    return  Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: _screen,
      ),//destination screen
      floatingActionButton: Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(isRtl ? math.pi : 0),
        child: SpeedDial(
          icon: Icons.add,
          backgroundColor: Colors.deepOrange,
          overlayColor: Colors.black,
          overlayOpacity: 0.4,
          children: [
            SpeedDialChild(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => UploadProperty(adsCode: '',)));
              },
              child: const Icon(Icons.real_estate_agent),
              backgroundColor: Colors.white,
              labelBackgroundColor: Colors.white,
              labelWidget: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(isRtl ? math.pi : 0),
                  child: Text(
                    "property".tr(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )),
            ),
            SpeedDialChild(
              child: const Icon(Icons.directions_car),
              backgroundColor: Colors.white,
              labelBackgroundColor: Colors.white,
              labelWidget: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(isRtl ? math.pi : 0),
                  child: Text(
                    "motor".tr(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        elevation: 10,
        height: MediaQuery.of(context).size.height*0.07,
        iconSize: 30,
        activeColor: Colors.deepOrange,
        splashColor: Colors.deepOrange,
        icons: iconList,
        activeIndex: _selectedIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => setState(() => _onTapped(index)),
        //other params
      ),
    );
  }
}

//Scaffold(
//       body: PageView(
//         controller: _pageController,
//         onPageChanged: _onPageChanged,
//         physics: const NeverScrollableScrollPhysics(),
//         children: _screen,
//       ),
//       bottomNavigationBar: Transform(
//         alignment: Alignment.center,
//         transform: Matrix4.rotationY(isRtl ? math.pi : 0),
//         child: ConvexAppBar(
//           initialActiveIndex : _selectedIndex,
//           onTap: _onTapped,
//           style: TabStyle.reactCircle,
//           elevation: 5,
//           backgroundColor: const Color.fromRGBO(64, 75, 96, .9),
//           height: MediaQuery.of(context).size.height*.07,
//           activeColor: Colors.deepOrange,
//           items: [
//             TabItem(icon: Icons.person,title: 'الملف الشخصي',),
//             TabItem(icon: Icons.search,title: 'بحث'),
//             TabItem(icon: Icons.add,title: 'إضافة إعلان',),
//             TabItem(icon: Icons.history_rounded,title: 'إعلاناتي',),
//             TabItem(icon: Icons.house,title: 'الرئيسية',),
//           ],
//         ),
//       ),
//     );