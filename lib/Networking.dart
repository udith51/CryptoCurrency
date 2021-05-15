import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Coin_Data.dart';

class Networking {
  Future<Map> getValue(String currentCurrency) async {
    String initialURL = 'https://rest.coinapi.io/v1/exchangerate';
    String apiKey = '3E622EEF-6F58-4025-94B1-4FB7FB4FE1F1';
    Map<String, String> threeValues = {};

    for (String crypto in cryptoList) {
      String url = '$initialURL/$crypto/$currentCurrency?apikey=$apiKey';
      print(url);
      http.Response response = await http.get(Uri.parse(url));
      print(response.statusCode);
      if (response.statusCode == 200) {
        double value = (jsonDecode(response.body)['rate']);
        threeValues[crypto] = value.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        // throw 'Error';
      }
    }
    return threeValues;
  }
}
