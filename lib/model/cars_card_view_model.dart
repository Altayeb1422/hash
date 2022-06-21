


// To parse this JSON data, do
//
//     final carsCardView = carsCardViewFromJson(jsonString);

import 'dart:convert';

List<CarsCardView> carsCardViewFromJson(String str) => List<CarsCardView>.from(json.decode(str).map((x) => CarsCardView.fromJson(x)));

String carsCardViewToJson(List<CarsCardView> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class CarsCardView {
  CarsCardView({
    this.clientId,
    this.id,
    this.fronPhoto,
    this.englishLabel,
    this.arabicLabel,
    this.areaName,
    this.price,
    this.currency,
    this.logo,
    this.engine,
    this.seen,
    this.title,
    this.date,
  });

  String? clientId;
  String? id;
  String? fronPhoto;
  String? englishLabel;
  String? arabicLabel;
  String? areaName;
  String? price;
  String? currency;
  String? logo;
  String? engine;
  String? seen;
  String? title;
  DateTime? date;

  factory CarsCardView.fromJson(Map<String, dynamic> json) => CarsCardView(
    clientId: json["client_Id"],
    id: json["ID"],
    fronPhoto: json["FronPhoto"],
    englishLabel: json["English_label"],
    arabicLabel: json["arabic_label"],
    areaName: json["AreaName"],
    price: json["Price"],
    currency: json["Currency"],
    logo: json["Logo"],
    engine: json["Engine"],
    seen: json["Seen"],
    title: json["Title"],
    date: DateTime.parse(json["Date"]),
  );

  Map<String, dynamic> toJson() => {
    "client_Id": clientId,
    "ID": id,
    "FronPhoto": fronPhoto,
    "English_label": englishLabel,
    "arabic_label": arabicLabel,
    "AreaName": areaName,
    "Price": price,
    "Currency": currency,
    "Logo": logo,
    "Engine": engine,
    "Seen": seen,
    "Title": title,
    "Date": "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
  };
}
