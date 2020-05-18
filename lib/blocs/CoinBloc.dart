import 'package:bitcoin_ticker/data/repository/CoinRepository.dart';
import 'package:bitcoin_ticker/data/responses/ExchangeRateResponse.dart';
import 'package:rxdart/rxdart.dart';

import '../utils/Response.dart';

class CoinBloc {
  CoinRepository _coinRepository = CoinRepository();
  final _btcRateFetcher = PublishSubject<Response<ExchangeRateResponse>>();
  final _ethRateFetcher = PublishSubject<Response<ExchangeRateResponse>>();
  final _ltcRateFetcher = PublishSubject<Response<ExchangeRateResponse>>();

  Stream<Response<ExchangeRateResponse>> get btcRate => _btcRateFetcher.stream;
  Stream<Response<ExchangeRateResponse>> get ethRate => _ethRateFetcher.stream;
  Stream<Response<ExchangeRateResponse>> get ltcRate => _ltcRateFetcher.stream;

  void getExchangeRate(String to) async {
    _btcRateFetcher.add(Response.loading('Getting currency'));
    _ethRateFetcher.add(Response.loading('Getting currency'));
    _ltcRateFetcher.add(Response.loading('Getting currency'));
    for (String crypto in cryptoList) {
      ExchangeRateResponse response =
          await _coinRepository.getExchangeRate(crypto, to);
      switch (crypto) {
        case 'BTC':
          _btcRateFetcher.add(Response.completed(response));
          break;
        case 'ETH':
          _ethRateFetcher.add(Response.completed(response));
          break;
        case 'LTC':
          _ltcRateFetcher.add(Response.completed(response));
          break;
      }
    }
  }

  void dispose() {
    _btcRateFetcher.close();
  }
}
