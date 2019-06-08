import 'networking.dart';
import 'constants.dart';
import 'package:http/http.dart' as http;
import 'price_screen.dart';

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

class CoinData {
  Future getBitcoinData(String selectedCurrency) async {
    String url = '$baseURL/BTC$selectedCurrency';
    var bitcoinData = await NetworkHelper(url).getData();
    return bitcoinData;
  }
}
