import 'networking.dart';
import 'constants.dart';

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

const List<String> cryptoList = ['BTC', 'ETH', 'LTC', 'XRP'];

class CoinData {
  Future getBitcoinData(String selectedCurrency) async {
    Map<String, List<dynamic>> cryptoPrices = {};

    for (String coin in cryptoList) {
      String url = '$baseURL$coin$selectedCurrency';
      var bitcoinData = await NetworkHelper(url).getData();
      double lastPrice = bitcoinData['last'];
      double percentChange = bitcoinData['changes']['percent']['hour'];

      cryptoPrices[coin] = [
        lastPrice.toStringAsFixed(2),
        percentChange.toStringAsFixed(2)
      ];
    }
    return cryptoPrices;
  }
}
