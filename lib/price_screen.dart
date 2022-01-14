import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'coin_data.dart';
import 'currency_networking.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  NetworkHelper networkHelper = NetworkHelper();
  String currencyOnScreen = 'USD';
  String rate = '?';

   Widget androindPicker() {
     List<DropdownMenuItem<String>> menuItems = [];
     for (String currencyItem in currenciesList) {
       var item = DropdownMenuItem(
         value: currencyItem,
         child: Text(currencyItem),
       );
       menuItems.add(item);
     }
     return DropdownButton<String>(
       value: currencyOnScreen,
       items: menuItems,
       onChanged: (value) {
         currencyOnScreen = value;
       },
     );
   }

   CupertinoPicker iosPicker(){

     List<Widget> valuesList = [];

     for( String text in currenciesList){
       var textValue = Text(text, style: TextStyle(fontSize: 19.0, color: Colors.white),);
       valuesList.add(textValue);
     }

     return  CupertinoPicker(
       itemExtent: 30.0,
       onSelectedItemChanged: (index) async{
         setState(() {
           currencyOnScreen = currenciesList[index];
         });
         await networkHelper.convertCurrency(currencyOnScreen);
         rate = networkHelper.toUSD();
       },
       children: valuesList,
     );
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $rate $currencyOnScreen',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker(): androindPicker()
          ),
        ],
      ),
    );
  }
}