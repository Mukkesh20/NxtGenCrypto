import 'package:NextGenCrypto/screens/coinMarket_screen.dart';
import 'package:NextGenCrypto/service/coinMarket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getCoinMarketData() async {
    try {
      CoinMarketModel coinMarketModel = CoinMarketModel();
      //CoinMarketScreen coinMarketScreen = CoinMarketScreen();
      var coinData = await coinMarketModel.getCoinMarketData('inr');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CoinMarketScreen(networkData: coinData),
        ),
      );
    } catch (err) {
      print(err);
      return err;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
