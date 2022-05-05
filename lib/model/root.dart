// To parse this JSON data, do
//
//     final tabs = tabsFromJson(jsonString);

import 'dart:convert';

List<Tabs> tabsFromJson(String str) => List<Tabs>.from(json.decode(str).map((x) => Tabs.fromJson(x)));

String tabsToJson(List<Tabs> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tabs {
  Tabs({
    required this.id,
    required this.name,
    required this.englishLabel,
    required this.arabicLabel,
    required this.parentId,
    required this.icon,
  });

  String id;
  String name;
  String englishLabel;
  String arabicLabel;
  String parentId;
  String icon;

  factory Tabs.fromJson(Map<String, dynamic> json) => Tabs(
    id: json["id"],
    name: json["name"],
    englishLabel: json["English_label"],
    arabicLabel: json["Arabic_label"],
    parentId: json["parent_id"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "English_label": englishLabel,
    "Arabic_label": arabicLabel,
    "parent_id": parentId,
    "icon": icon,
  };
}
