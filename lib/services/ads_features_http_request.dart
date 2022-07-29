import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../model/property_amenities_model.dart';


class AdsFeaturesService
{
  Future<List<PropertyAmenities>?> adsFeatures(id) async {
    var client = http.Client();
    var res = await client.get(Uri.parse("http://192.168.15.124/easy/fetch_ads_featurs (2).php?Ads_Id="+id),);
    if(res.statusCode == 200){
      debugPrint("Cars posted successfully");
      print(res.body);
      var jason = res.body;
      return propertyAmenitiesFromJson(jason);
    }else{
      debugPrint("Something went wrong! Status Code is: ${res.statusCode}");
    }
  }

}