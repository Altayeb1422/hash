import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


class propertyUpload {
  Future propertyMainUpload(Client_ID, AdsCode, Select2, Select3, Select4,Rooms,Bathrooms,Floors, Space,
      GeneralDescription, Price, CityName, AreaName) async {
    var res = await http
        .post(Uri.parse("http://192.168.15.116/easy/insert_ads.php"), body: {
      Client_ID,
      AdsCode,
      Select2,
      Select3,
      Select4,
      Rooms,
      Bathrooms,
      Floors,
      Space,
      GeneralDescription,
      Price,
      CityName,
      AreaName
    });
    if (res.statusCode == 200) {
      debugPrint("Data posted successfully");
    } else {
      debugPrint("Something went wrong! Status Code is: ${res.statusCode}");
    }
  }
}
