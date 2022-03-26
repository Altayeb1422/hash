import 'package:flutter/material.dart';
import '../menu_items.dart';
import 'package:easy_localization/easy_localization.dart';

class MenuItems{
  static MenuItem home = MenuItem("home".tr(), Icons.home);
  static  MenuItem notifications = MenuItem("Noitf".tr(), Icons.notifications);
  static  MenuItem history = MenuItem("history".tr(), Icons.history_rounded);
  static  MenuItem favorite = MenuItem("fav".tr(), Icons.favorite);
  static  MenuItem settings = MenuItem("settings".tr(), Icons.settings);
  static  MenuItem contact = MenuItem("contact".tr(), Icons.contact_support);

  static  List<MenuItem> all =<MenuItem> [
    home,
    notifications,
    favorite,
    history,
    settings,
    contact,
  ];
}