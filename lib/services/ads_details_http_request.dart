import 'package:flutter/cupertino.dart';
import 'package:hash/model/fetch_property_detailes_model.dart';
import 'package:http/http.dart' as http;
import '../model/fetch_car_detailes_model.dart';


class AdsDetailsService
{
   Future <FetchCarDetails?> postCarsAdID(id) async {
    var client = http.Client();
    var res = await client.get(Uri.parse("http://192.168.15.124/easy/fetch_care.php?ID="+id),);
    if(res.statusCode == 200){
      debugPrint("Cars posted successfully");
      print(res.body);
      var jason = res.body;
      return fetchCarDetailsFromJson(jason);
    }else{
      debugPrint("Something went wrong! Status Code is: ${res.statusCode}");
    }
  }
   Future<FetchPropertyDetails?> postPropertyAdID(id) async {
     var client = http.Client();
     var res = await client.get(Uri.parse("http://192.168.15.124/easy/fetch_realstate.php?ID="+id.toString()),);
     if(res.statusCode == 200){
       debugPrint("Property posted successfully");
       print(res.body);
       var jason = res.body;
       return fetchPropertyDetailsFromJson(jason);
     }else{
       debugPrint("Something went wrong! Status Code is: ${res.statusCode}");
     }
   }

}