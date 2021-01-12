import 'package:NextGenCrypto/service/network_helper.dart';

const currencyListURL =
    'https://api.coingecko.com/api/v3/simple/supported_vs_currencies';

class CurrencyListModel {
  Future<dynamic> getCurrencyListData() async {
    NetworkHelper networkHelper = NetworkHelper(currencyListURL);

    var currencyListData = await networkHelper.getData();
    return currencyListData;
  }
}
