import 'package:NextGenCrypto/screens/coinMarket_screen.dart';
import 'package:NextGenCrypto/service/coinMarket.dart';
import 'package:NextGenCrypto/utilities/card_data.dart';
import 'package:NextGenCrypto/utilities/reusable_box.dart';
import 'package:async_loader/async_loader.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      new GlobalKey<AsyncLoaderState>();
  CoinMarketModel coinMarketModel = CoinMarketModel();
  var coinData;

  @override
  void initState() {
    super.initState();
  }

  void getCoinMarketData() async {
    try {
      CoinMarketModel coinMarketModel = CoinMarketModel();
      //CoinMarketScreen coinMarketScreen = CoinMarketScreen();
      coinData = await coinMarketModel.getCoinMarketData('inr');
    } catch (err) {
      print(err);
      return err;
    }
  }

  getMessage() async {
    return Future.delayed(Duration(seconds: 1), () => '');
  }

  @override
  Widget build(BuildContext context) {
    var _asyncLoader = AsyncLoader(
      key: _asyncLoaderState,
      initState: () async => await getMessage(),
      renderLoad: () => CircularProgressIndicator(),
      renderError: ([error]) =>
          new Text('Sorry, there was an error loading your joke'),
      renderSuccess: ({data}) => Text(data),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NextGenCrypto',
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        children: [
          _asyncLoader,
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ReusableBox(
                          onPress: () async {
                            _asyncLoaderState.currentState
                                .reloadState()
                                .whenComplete(() => print('finished reload'));
                            coinData =
                                await coinMarketModel.getCoinMarketData('inr');
                            setState(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CoinMarketScreen(networkData: coinData),
                                ),
                              );
                            });
                          },
                          colour: Colors.lightGreen,
                          cardChild: CardData(
                            cardText: 'Crypto List',
                            icon: FontAwesomeIcons.bitcoin,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ReusableBox(
                          onPress: () {
                            setState(() {});
                          },
                          colour: Colors.lightGreen,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: ReusableBox(
                          onPress: () {
                            setState(() {});
                          },
                          colour: Colors.lightGreen,
                        ),
                      ),
                      Expanded(
                        child: ReusableBox(
                          onPress: () {
                            setState(() {});
                          },
                          colour: Colors.lightGreen,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
