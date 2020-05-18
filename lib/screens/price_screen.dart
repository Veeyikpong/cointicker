import 'package:bitcoin_ticker/blocs/CoinBloc.dart';
import 'package:bitcoin_ticker/data/responses/ExchangeRateResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import '../data/repository/CoinRepository.dart';
import '../utils/Response.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  final coinBloc = CoinBloc();

  String selectedCurrency = 'USD';

  DropdownButton<String> getAndroidDropdown() {
    List<DropdownMenuItem<String>> dropDownList = [];
    for (String currency in currenciesList) {
      dropDownList.add(DropdownMenuItem(
        child: Text(currency),
        value: currency,
      ));
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownList,
      onChanged: (item) {
        setState(() {
          coinBloc.getExchangeRate(item);
          selectedCurrency = item;
        });
      },
    );
  }

  CupertinoPicker getIOSPicker() {
    List<Text> pickerItemList = [];
    for (String currency in currenciesList) {
      pickerItemList.add(Text(
        currency,
        style: TextStyle(color: Colors.white),
      ));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        coinBloc.getExchangeRate(currenciesList[selectedIndex]);
      },
      children: pickerItemList,
    );
  }

  @override
  void initState() {
    super.initState();
    coinBloc.getExchangeRate(selectedCurrency);
  }

  @override
  void dispose() {
    super.dispose();
    coinBloc.dispose();
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StreamBuilder(
                stream: coinBloc.btcRate,
                builder: (context,
                    AsyncSnapshot<Response<ExchangeRateResponse>> snapshot) {
                  if (snapshot.hasData) {
                    switch (snapshot.data.status) {
                      case Status.COMPLETED:
                        return currencyTextView(
                            snapshot.data.data.fromCurrency,
                            snapshot.data.data.toCurrency,
                            snapshot.data.data.rate);
                        break;
                      case Status.LOADING:
                        return currencyLoadingView(snapshot.data.message);
                        break;
                      case Status.ERROR:
                        return errorView(snapshot.data.message);
                        break;
                    }
                  }
                  return currencyLoadingView('Getting currency');
                },
              ),
              StreamBuilder(
                stream: coinBloc.ethRate,
                builder: (context,
                    AsyncSnapshot<Response<ExchangeRateResponse>> snapshot) {
                  if (snapshot.hasData) {
                    switch (snapshot.data.status) {
                      case Status.COMPLETED:
                        return currencyTextView(
                            snapshot.data.data.fromCurrency,
                            snapshot.data.data.toCurrency,
                            snapshot.data.data.rate);
                        break;
                      case Status.LOADING:
                        return currencyLoadingView(snapshot.data.message);
                        break;
                      case Status.ERROR:
                        return errorView(snapshot.data.message);
                        break;
                    }
                  }
                  return currencyLoadingView('Getting currency');
                },
              ),
              StreamBuilder(
                stream: coinBloc.ltcRate,
                builder: (context,
                    AsyncSnapshot<Response<ExchangeRateResponse>> snapshot) {
                  if (snapshot.hasData) {
                    switch (snapshot.data.status) {
                      case Status.COMPLETED:
                        return currencyTextView(
                            snapshot.data.data.fromCurrency,
                            snapshot.data.data.toCurrency,
                            snapshot.data.data.rate);
                        break;
                      case Status.LOADING:
                        return currencyLoadingView(snapshot.data.message);
                        break;
                      case Status.ERROR:
                        return errorView(snapshot.data.message);
                        break;
                    }
                  }
                  return currencyLoadingView('Getting currency');
                },
              ),
            ],
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS ? getIOSPicker() : getAndroidDropdown())
        ],
      ),
    );
  }

  Widget currencyTextView(String source, String from, double rate) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text('1 $source = ${rate.roundToDouble()} $from',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              )),
        ),
      ),
    );
  }

  Widget currencyLoadingView(String loadingText) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(loadingText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              )),
        ),
      ),
    );
  }

  Widget errorView(errorText) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(errorText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}
