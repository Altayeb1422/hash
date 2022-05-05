// To parse this JSON data, do
//
//     final filterTabs = filterTabsFromJson(jsonString);

import 'dart:convert';

List<FilterTabs> filterTabsFromJson(String str) => List<FilterTabs>.from(json.decode(str).map((x) => FilterTabs.fromJson(x)));

String filterTabsToJson(List<FilterTabs> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FilterTabs {
  FilterTabs({
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
  String? arabicLabel;
  String parentId;
  String icon;

  factory FilterTabs.fromJson(Map<String, dynamic> json) => FilterTabs(
    id: json["id"],
    name: json["name"],
    englishLabel: json["English_label"],
    arabicLabel: json["arabic_label"],
    parentId: json["parent_id"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "English_label": englishLabel,
    "arabic_label": arabicLabel,
    "parent_id": parentId,
    "icon": icon,
  };
}
