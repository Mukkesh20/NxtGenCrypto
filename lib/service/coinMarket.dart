import 'package:NextGenCrypto/service/network_helper.dart';

const coinMarketURL = 'https://api.coingecko.com/api/v3/coins/markets';
const defaultParam =
    'order=market_cap_desc&per_page=250&page=1&sparkline=false&price_change_percentage=1h%2C24h%2C7d%2C14d%2C30d';

class CoinMarketModel {
  Future<dynamic> getCoinMarketData(String currCode) async {
    NetworkHelper networkHelper =
        NetworkHelper('$coinMarketURL?vs_currency=$currCode&$defaultParam');

    var coinMarketData = await networkHelper.getData();
    return coinMarketData;
  }
}
