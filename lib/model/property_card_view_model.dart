// To parse this JSON data, do
//
//     final propertyCardView = propertyCardViewFromJson(jsonString);

import 'dart:convert';

List<PropertyCardView> propertyCardViewFromJson(String str) => List<PropertyCardView>.from(json.decode(str).map((x) => PropertyCardView.fromJson(x)));

String propertyCardViewToJson(List<PropertyCardView> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PropertyCardView {
  PropertyCardView({
    this.id,
    this.fronPhoto,
    this.englishLabel,
    this.arabicLabel,
    this.areaName,
    this.price,
    this.currancy,
    this.period,
    this.seen,
    this.titel,
    this.date,
  });

  String? id;
  String? fronPhoto;
  String? englishLabel;
  String? arabicLabel;
  String? areaName;
  String? price;
  String? currancy;
  String? period;
  String? seen;
  String? titel;
  DateTime? date;

  factory PropertyCardView.fromJson(Map<String, dynamic> json) => PropertyCardView(
    id: json["ID"],
    fronPhoto: json["FronPhoto"],
    englishLabel: json["English_label"],
    arabicLabel: json["arabic_label"],
    areaName: json["AreaName"],
    price: json["Price"],
    currancy: json["Currancy"],
    period: json["Period"],
    seen: json["Seen"],
    titel: json["Titel"],
    date: DateTime.parse(json["Date"]),
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "FronPhoto": fronPhoto,
    "English_label": englishLabel,
    "arabic_label": arabicLabel,
    "AreaName": areaName,
    "Price": price,
    "Currancy": currancy,
    "Period": period,
    "Seen": seen,
    "Titel": titel,
    "Date": "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
  };
}
