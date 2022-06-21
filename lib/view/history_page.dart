import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hash/view/property_history.dart';
import 'package:hash/view/motors/motors.dart';
import 'package:easy_localization/easy_localization.dart';

import 'cars_history.dart';

DateTime logout = DateTime.now();

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with TickerProviderStateMixin {
  final List<MyTabs> _tabs = [
    MyTabs(
      title: "Property".tr(),
    ),
    MyTabs(
      title: "Cars".tr(),
    ),
  ];
  late MyTabs _myHandler;
  late TabController _tabController;

  getUser() {
    FirebaseAuth.instance.currentUser;
  }

  @override
  void initState() {
    getUser();
    _myHandler = _tabs[0];
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleSelected);
    super.initState();
  }

  void _handleSelected() {
    setState(() {
      _myHandler = _tabs[_tabController.index];
    });
  }

  @override
  Widget build(BuildContext context) {
    context.locale;
    bool isRtl = Directionality.of(context).index == 0;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
        systemStatusBarContrastEnforced: true,
    ));
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
        overlays: [SystemUiOverlay.top]);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "History",
          style: const TextStyle(color: Colors.black),
        )),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        bottom: TabBar(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          isScrollable: true,
          physics: const BouncingScrollPhysics(),
          labelColor: const Color(0xffe55729),
          unselectedLabelColor: Colors.grey,
          controller: _tabController,
          indicator:
          CircleIndicator(color: const Color(0xffe55729), radius: 4),
          tabs: [
            Tab(
              text: _tabs[0].title,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Tab(
                text: _tabs[1].title,
              ),
            ),
          ],
        ),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: TabBarView(
          controller: _tabController,
          children:  [
            PropertyHistory(),
            CarsHistory(),
          ],
        ),
      ),
    );
  }
}

class CircleIndicator extends Decoration {
  final color;
  double radius;

  CircleIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final double radius;
  late Color color;
  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    late Paint _paint;
    _paint = Paint()..color = color;
    _paint = _paint..isAntiAlias = true;
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}

class MyTabs {
  final String title;
  MyTabs({required this.title});
}
