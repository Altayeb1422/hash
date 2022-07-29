// To parse this JSON data, do
//
//     final propertyAmenities = propertyAmenitiesFromJson(jsonString);

import 'dart:convert';

List<PropertyAmenities> propertyAmenitiesFromJson(String str) => List<PropertyAmenities>.from(json.decode(str).map((x) => PropertyAmenities.fromJson(x)));

String propertyAmenitiesToJson(List<PropertyAmenities> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PropertyAmenities {
  PropertyAmenities({
    this.adsId,
    this.name,
    this.arabicLabel,
    this.icon,
  });

  String? adsId;
  String? name;
  String? arabicLabel;
  String? icon;

  factory PropertyAmenities.fromJson(Map<String, dynamic> json) => PropertyAmenities(
    adsId: json["Ads_Id"],
    name: json["Name"],
    arabicLabel: json["arabic_label"],
    icon: json["Icon"],
  );

  Map<String, dynamic> toJson() => {
    "Ads_Id": adsId,
    "Name": name,
    "arabic_label": arabicLabel,
    "Icon": icon,
  };
}
