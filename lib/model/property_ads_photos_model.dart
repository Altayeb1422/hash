// To parse this JSON data, do
//
//     final propertyAdsPhotos = propertyAdsPhotosFromJson(jsonString);

import 'dart:convert';

List<PropertyAdsPhotos> propertyAdsPhotosFromJson(String str) => List<PropertyAdsPhotos>.from(json.decode(str).map((x) => PropertyAdsPhotos.fromJson(x)));

String propertyAdsPhotosToJson(List<PropertyAdsPhotos> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PropertyAdsPhotos {
  PropertyAdsPhotos({
    this.photoName,
  });

  String? photoName;

  factory PropertyAdsPhotos.fromJson(Map<String, dynamic> json) => PropertyAdsPhotos(
    photoName: json["PhotoName"],
  );

  Map<String, dynamic> toJson() => {
    "PhotoName": photoName,
  };
}
