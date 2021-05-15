import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Coin_Data.dart';
import 'dart:io' show Platform;
import 'Networking.dart';
import 'Reusable_Card.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String currentCurrency = 'AUD';
  Map coinValue = {};
  Networking networking = Networking();

  // ignore: missing_return
  Widget platform() {
    if (Platform.isIOS) {
      return iOS();
    } else if (Platform.isAndroid) {
      return android();
    }
  }

  DropdownButton android() {
    List<DropdownMenuItem> dropDownMenuItems = [];
    for (String currency in currenciesList) {
      dropDownMenuItems.add(
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      );
    }
    return DropdownButton(
      value: currentCurrency,
      items: dropDownMenuItems,
      onChanged: (value) {
        setState(
          () {
            currentCurrency = value;
            coinValues();
          },
        );
      },
    );
  }

  CupertinoPicker iOS() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        setState(
          () {
            currentCurrency = currenciesList[selectedIndex];
            coinValues();
          },
        );
      },
      children: pickerItems,
    );
  }

  void coinValues() async {
    try {
      setState(
        () {
          coinValue['BTC'] = '?';
          coinValue['ETH'] = '?';
          coinValue['LTC'] = '?';
        },
      );
      Map temp = await networking.getValue(currentCurrency);
      setState(
        () {
          coinValue = temp;
        },
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    coinValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bitcoin Ticker'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ReusableCard(
                cryptoCurrency: 'BTC',
                coinValue: coinValue['BTC'],
                currentCurrency: currentCurrency,
              ),
              ReusableCard(
                cryptoCurrency: 'ETH',
                coinValue: coinValue['ETH'],
                currentCurrency: currentCurrency,
              ),
              ReusableCard(
                cryptoCurrency: 'LTC',
                coinValue: coinValue['LTC'],
                currentCurrency: currentCurrency,
              ),
            ],
          ),
          Container(
            color: Colors.lightBlue,
            alignment: Alignment.center,
            child: platform(),
            height: 100,
          ),
        ],
      ),
    );
  }
}
