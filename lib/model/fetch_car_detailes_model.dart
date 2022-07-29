// To parse this JSON data, do
//
//     final fetchCarDetails = fetchCarDetailsFromJson(jsonString);

import 'dart:convert';

FetchCarDetails fetchCarDetailsFromJson(String str) => FetchCarDetails.fromJson(json.decode(str));

String fetchCarDetailsToJson(FetchCarDetails data) => json.encode(data.toJson());

class FetchCarDetails {
  FetchCarDetails({
    this.id,
    this.clientId,
    this.adsCode,
    this.select2,
    this.select3,
    this.select4,
    this.date,
    this.title,
    this.logo,
    this.price,
    this.currency,
    this.seats,
    this.engine,
    this.model,
    this.color,
    this.distance,
    this.fuel,
    this.state,
    this.location,
    this.phone,
    this.generalDescription,
    this.cityName,
    this.areaName,
    this.status,
    this.seen,
    this.fronPhoto,
    this.uploadTime,
    this.paymentStatus,
  });

  String? id;
  String? clientId;
  String? adsCode;
  String? select2;
  String? select3;
  String? select4;
  DateTime? date;
  String? title;
  String? logo;
  String? price;
  String? currency;
  String? seats;
  String? engine;
  String? model;
  String? color;
  String? distance;
  String? fuel;
  String? state;
  String? location;
  String? phone;
  String? generalDescription;
  String? cityName;
  String? areaName;
  String? status;
  String? seen;
  String? fronPhoto;
  String? uploadTime;
  String? paymentStatus;

  factory FetchCarDetails.fromJson(Map<String, dynamic> json) => FetchCarDetails(
    id: json["ID"],
    clientId: json["Client_ID"],
    adsCode: json["AdsCode"],
    select2: json["Select2"],
    select3: json["Select3"],
    select4: json["Select4"],
    date: DateTime.parse(json["Date"]),
    title: json["Title"],
    logo: json["Logo"],
    price: json["Price"],
    currency: json["Currency"],
    seats: json["Seats"],
    engine: json["Engine"],
    model: json["Model"],
    color: json["Color"],
    distance: json["Distance"],
    fuel: json["Fuel"],
    state: json["State"],
    location: json["Location"],
    phone: json["phone"],
    generalDescription: json["GeneralDescription"],
    cityName: json["CityName"],
    areaName: json["AreaName"],
    status: json["Status"],
    seen: json["Seen"],
    fronPhoto: json["FronPhoto"],
    uploadTime: json["UploadTime"],
    paymentStatus: json["PaymentStatus"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Client_ID": clientId,
    "AdsCode": adsCode,
    "Select2": select2,
    "Select3": select3,
    "Select4": select4,
    "Date": "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
    "Title": title,
    "Logo": logo,
    "Price": price,
    "Currency": currency,
    "Seats": seats,
    "Engine": engine,
    "Model": model,
    "Color": color,
    "Distance": distance,
    "Fuel": fuel,
    "State": state,
    "Location": location,
    "phone": phone,
    "GeneralDescription": generalDescription,
    "CityName": cityName,
    "AreaName": areaName,
    "Status": status,
    "Seen": seen,
    "FronPhoto": fronPhoto,
    "UploadTime": uploadTime,
    "PaymentStatus": paymentStatus,
  };
}
