import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final String cryptoCurrency;
  final String coinValue;
  final String currentCurrency;

  ReusableCard({this.currentCurrency, this.coinValue, this.cryptoCurrency});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      color: Colors.lightBlue,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Text(
          '1 $cryptoCurrency =  $coinValue $currentCurrency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
