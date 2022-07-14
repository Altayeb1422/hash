import 'package:http/http.dart' as http;

import '../model/cars_card_view_model.dart';
import '../model/property_card_view_model.dart';


class FrontViewCard
{
  Future<List<PropertyCardView>?> propertyCardView() async
  {
    var client = http.Client();
    var uri = Uri.parse("http://192.168.1.37/easy/realstate_cardView_view.php");
    var response = await client.get(uri);
    if(response.statusCode == 200)
    {
      var json = response.body;
      return propertyCardViewFromJson(json);
    }
  }
  Future<List<CarsCardView>?> carsCardView() async
  {
    var client = http.Client();
    var uri = Uri.parse("http://192.168.1.37/easy/cars_cardView_view.php");
    var response = await client.get(uri);
    if(response.statusCode == 200)
    {
      var json = response.body;
      return carsCardViewFromJson(json);
    }
  }
}