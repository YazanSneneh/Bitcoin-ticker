import 'dart:convert';
import 'package:http/http.dart';

class NetworkHelper {
  String rate;

  void convertCurrency(String convertedCurrency)async {
    String url = 'https://rest.coinapi.io/v1/exchangerate/BTC/$convertedCurrency?apiKey=69A0FB95-4AEF-440A-9C4B-3298EE1032C3';
    Response response;

    try{
      response = await get(Uri.parse(url));
      var body = jsonDecode(response.body);
      double currencyRate = body['rate'];
      rate = currencyRate.toStringAsFixed(1);
    }catch(e){
      print('Statuss code ${response.statusCode}');
    }
  }

  String toUSD(){
    return rate;
  }

}