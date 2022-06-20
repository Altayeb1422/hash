import 'package:http/http.dart' as http;

import '../model/property_card_view_model.dart';






class HistoryViewCard
{
  Future<List<PropertyCardView>?> propertyCardView() async
  {
    var client = http.Client();
    var uri = Uri.parse("http://192.168.15.122/easy/realstate_cardView_view.php");
    var response = await client.get(uri);
    if(response.statusCode == 200)
    {
      var json = response.body;
      return propertyCardViewFromJson(json);
    }
  }
}