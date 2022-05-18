// import 'package:flutter/material.dart';
// import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
// import 'package:hash/view/search.dart';
// import 'package:hash/view/favorite.dart';
// import 'package:hash/view/history.dart';
// import 'package:hash/view/home_page.dart';
// import 'package:hash/view/menu_screen.dart';
// import 'package:hash/view/notifications_page.dart';
// import 'package:hash/view/user.dart';
// import '../model/menu_items_class.dart';
// import 'home_body.dart';
//
// class ZoomDrawerRoute extends StatefulWidget {
//   const ZoomDrawerRoute({Key? key}) : super(key: key);
//
//
//   @override
//   _ZoomDrawerRouteState createState() => _ZoomDrawerRouteState();
// }
//
// class _ZoomDrawerRouteState extends State<ZoomDrawerRoute> {
//   MenuItem currentItem = MenuItems.home;
//
//   @override
//   Widget build(BuildContext context) {
//     bool isRtl = Directionality.of(context).index == 0;
//     return ZoomDrawer(
//       slideWidth: 240,
//       swipeOffset: 10,
//       showShadow: true,
//       angle: 0.0,
//       isRtl: isRtl,
//       shadowLayer1Color: Colors.redAccent.withOpacity(0.8),
//       shadowLayer2Color: const Color.fromRGBO(64, 77, 96, 1),
//       menuScreen: Builder(
//         builder: (context) {
//           return MenuPage(
//             currentItem: currentItem,
//             onSelectedItem: (item){
//               setState(() {
//                 currentItem = item;
//                 ZoomDrawer.of(context)!.close();
//               });
//             }
//           );
//         }
//       ),
//       mainScreen:  getScreen());
//   }
//   getScreen() {
//     if(currentItem == MenuItems.home){
//       return const HomeBody();
//     }else if (currentItem == MenuItems.notifications){
//       return const Notifications();
//     }else if (currentItem == MenuItems.favorite){
//       return const Favorite();
//     }else if (currentItem == MenuItems.history){
//       return const History();
//     }else if (currentItem == MenuItems.settings){
//       return const Settings();
//     }else if (currentItem == MenuItems.contact){
//       return const ContactUs();
//     }
//   }
// }
