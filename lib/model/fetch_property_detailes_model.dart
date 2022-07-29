// To parse this JSON data, do
//
//     final fetchPropertyDetails = fetchPropertyDetailsFromJson(jsonString);

import 'dart:convert';

FetchPropertyDetails fetchPropertyDetailsFromJson(String str) => FetchPropertyDetails.fromJson(json.decode(str));

String fetchPropertyDetailsToJson(FetchPropertyDetails data) => json.encode(data.toJson());

class FetchPropertyDetails {
  FetchPropertyDetails({
    this.id,
    this.clientId,
    this.adsCode,
    this.select2,
    this.select3,
    this.select4,
    this.date,
    this.space,
    this.rooms,
    this.bathrooms,
    this.floors,
    this.location,
    this.phone,
    this.generalDescription,
    this.price,
    this.cityName,
    this.areaName,
    this.status,
    this.seen,
    this.fronPhoto,
    this.uploadTime,
    this.paymentStatus,
    this.currancy,
    this.titel,
    this.period,
  });

  String? id;
  String? clientId;
  String? adsCode;
  String? select2;
  String? select3;
  String? select4;
  DateTime? date;
  String? space;
  String? rooms;
  String? bathrooms;
  String? floors;
  String? location;
  String? phone;
  String? generalDescription;
  String? price;
  String? cityName;
  String? areaName;
  String? status;
  String? seen;
  String? fronPhoto;
  String? uploadTime;
  String? paymentStatus;
  String? currancy;
  String? titel;
  String? period;

  factory FetchPropertyDetails.fromJson(Map<String, dynamic> json) => FetchPropertyDetails(
    id: json["ID"],
    clientId: json["Client_ID"],
    adsCode: json["AdsCode"],
    select2: json["Select2"],
    select3: json["Select3"],
    select4: json["Select4"],
    date: DateTime.parse(json["Date"]),
    space: json["Space"],
    rooms: json["Rooms"],
    bathrooms: json["Bathrooms"],
    floors: json["Floors"],
    location: json["Location"],
    phone: json["phone"],
    generalDescription: json["GeneralDescription"],
    price: json["Price"],
    cityName: json["CityName"],
    areaName: json["AreaName"],
    status: json["Status"],
    seen: json["Seen"],
    fronPhoto: json["FronPhoto"],
    uploadTime: json["UploadTime"],
    paymentStatus: json["PaymentStatus"],
    currancy: json["Currancy"],
    titel: json["Titel"],
    period: json["Period"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Client_ID": clientId,
    "AdsCode": adsCode,
    "Select2": select2,
    "Select3": select3,
    "Select4": select4,
    "Date": "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
    "Space": space,
    "Rooms": rooms,
    "Bathrooms": bathrooms,
    "Floors": floors,
    "Location": location,
    "phone": phone,
    "GeneralDescription": generalDescription,
    "Price": price,
    "CityName": cityName,
    "AreaName": areaName,
    "Status": status,
    "Seen": seen,
    "FronPhoto": fronPhoto,
    "UploadTime": uploadTime,
    "PaymentStatus": paymentStatus,
    "Currancy": currancy,
    "Titel": titel,
    "Period": period,
  };
}
