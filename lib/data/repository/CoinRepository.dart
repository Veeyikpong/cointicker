import 'package:bitcoin_ticker/ApiProvider.dart';
import 'package:bitcoin_ticker/data/responses/ExchangeRateResponse.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const apiKey = 'BAB1E798-D1C6-4C1D-918D-49BC37B35F28';

class CoinRepository {
  ApiProvider _apiProvider = ApiProvider();

  Future<ExchangeRateResponse> getExchangeRate(String source, String to) async {
    try {
      final response =
          await _apiProvider.get('exchangerate/$source/$to?apikey=$apiKey');
      return ExchangeRateResponse.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
