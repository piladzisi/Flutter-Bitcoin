import 'package:flutter/material.dart';
import 'constants.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'coinCard.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        selectedCurrency = value;
        getData();
      },
    );
  }

  NotificationListener iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      var newItem = Text(
        currency,
        style: TextStyle(
          fontSize: 20.0,
        ),
      );
      pickerItems.add(newItem);
    }
    return NotificationListener<ScrollEndNotification>(
      onNotification: (notification) {
        getData();
      },
      child: CupertinoPicker(
        backgroundColor: kDarkPrimaryColor,
        looping: true,
        itemExtent: 36.0,
        onSelectedItemChanged: (selectedIndex) {
          selectedCurrency = currenciesList[selectedIndex];
        },
        children: pickerItems,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Map<String, List<dynamic>> coinValues = {};
  bool isWaiting = false;

  void getData() async {
    isWaiting = true;
    try {
      var data = await CoinData().getBitcoinData(selectedCurrency);
      isWaiting = false;
      setState(() {
        coinValues = data;
        print(coinValues);
      });
    } catch (e) {
      print(e);
    }
  }

  Column makeCards() {
    List<CoinCard> cryptoCards = [];
    for (String coin in cryptoList) {
      cryptoCards.add(
        CoinCard(
          coin: coin,
          selectedCurrency: selectedCurrency,
          value: isWaiting ? '' : coinValues[coin][0],
          percentDay: isWaiting ? '' : coinValues[coin][1] + '%',
          fullName: isWaiting ? '' : coinValues[coin][2],
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cryptoCards,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto Market'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          makeCards(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: kDarkPrimaryColor,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
