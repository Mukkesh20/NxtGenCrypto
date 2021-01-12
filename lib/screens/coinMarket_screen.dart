import 'package:NextGenCrypto/screens/loading_screen.dart';
import 'package:NextGenCrypto/screens/reload_screen.dart';
import 'package:NextGenCrypto/service/currencyList.dart';
import 'package:NextGenCrypto/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../service/coinMarket.dart';

const flutterColor = Color(0xFF40D0FD);

class CoinMarketScreen extends StatefulWidget {
  CoinMarketScreen({this.networkData});
  final List<dynamic> networkData;

  @override
  _CoinMarketScreenState createState() => _CoinMarketScreenState();
}

class _CoinMarketScreenState extends State<CoinMarketScreen> {
  HDTRefreshController _hdtRefreshController = HDTRefreshController();
  CoinMarketModel coinMarketModel = CoinMarketModel();

  static const int sortNumber = 0;
  bool isAscending = true;
  int sortType = sortNumber;
  List<CoinMarket> coinMarketData = [];
  bool iconSelected = false;
  List<dynamic> currencyList = kCurrencyList;
  String selectedCurrency = 'inr';

  @override
  void initState() {
    super.initState();
    updateUI(widget.networkData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Spacer(),
          Center(
            child: Text(
              'NextGenCrypto',
              textAlign: TextAlign.center,
            ),
          ),
          Spacer(),
          DropdownButton<dynamic>(
            hint: Text(selectedCurrency),
            value: selectedCurrency,
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (dynamic value) async {
              updateUI(
                await coinMarketModel.getCoinMarketData(value),
              );
              setState(() {
                selectedCurrency = value;
                print(selectedCurrency);
              });
            },
            items: currencyList.map<DropdownMenuItem<dynamic>>((dynamic value) {
              return DropdownMenuItem<dynamic>(
                value: value,
                child: Text(
                  value,
                  style: kDropdownTextStyle,
                ),
              );
            }).toList(),
          ),
        ],
      )),
      body: _getBodyWidget(),
    );
  }

  updateUI(dynamic networkData) async {
    var bigNumFormatter = NumberFormat('#,###,000');
    setState(() {
      if (networkData == null) {
        Alert(
          context: context,
          type: AlertType.error,
          title: "RFLUTTER ALERT",
          desc: "Flutter is more awesome with RFlutter Alert.",
          buttons: [
            DialogButton(
              child: Text(
                "COOL",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
        return;
      }

      coinMarketData.clear();
      for (int i = 0; i < networkData.length; i++) {
        coinMarketData.add(
          CoinMarket(
            networkData[i]['name'],
            networkData[i]['image'],
            networkData[i]['current_price'].toStringAsFixed(
                networkData[i]['current_price'].truncateToDouble() ==
                        networkData[i]['current_price']
                    ? 0
                    : 6),
            bigNumFormatter.format(networkData[i]['total_volume']).toString(),
            bigNumFormatter.format(networkData[i]['market_cap']).toString(),
            networkData[i]['price_change_percentage_1h_in_currency']
                .toStringAsFixed(networkData[i]
                                ['price_change_percentage_1h_in_currency']
                            .truncateToDouble() ==
                        networkData[i]['price_change_percentage_1h_in_currency']
                    ? 0
                    : 2),
            networkData[i]['price_change_percentage_24h_in_currency']
                .toStringAsFixed(networkData[i]
                                ['price_change_percentage_24h_in_currency']
                            .truncateToDouble() ==
                        networkData[i]
                            ['price_change_percentage_24h_in_currency']
                    ? 0
                    : 2),
            networkData[i]['price_change_percentage_7d_in_currency']
                .toStringAsFixed(networkData[i]
                                ['price_change_percentage_7d_in_currency']
                            .truncateToDouble() ==
                        networkData[i]['price_change_percentage_7d_in_currency']
                    ? 0
                    : 2),
          ),
        );
      }
    });
  }

  Widget _getBodyWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Column(
        //   children: [
        //     Text(
        //       '',
        //     ),
        //   ],
        // ),
        Expanded(
          child: HorizontalDataTable(
            leftHandSideColumnWidth: 100,
            rightHandSideColumnWidth: 750,
            isFixedHeader: true,
            headerWidgets: _getTitleWidget(),
            leftSideItemBuilder: _generateFirstColumnRow,
            rightSideItemBuilder: _generateRightHandSideColumnRow,
            itemCount: 250,
            rowSeparatorWidget: const Divider(
              color: Colors.white60,
              height: 1.0,
              thickness: 0.5,
            ),
            leftHandSideColBackgroundColor: Color(0xFF000000),
            rightHandSideColBackgroundColor: Color(0xFF000000),
            enablePullToRefresh: true,
            refreshIndicator: const WaterDropHeader(),
            refreshIndicatorHeight: 60,
            onRefresh: () async {
              updateUI(
                  await coinMarketModel.getCoinMarketData(selectedCurrency));
              setState(() {
                _hdtRefreshController.refreshCompleted();
              });
            },
            htdRefreshController: _hdtRefreshController,
          ),
          //height: MediaQuery.of(context).size.height,
        ),
      ],
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('Coin', 100),
      _getTitleItemWidget('Icon', 50),
      FlatButton(
        padding: EdgeInsets.all(0),
        child: _getTitleItemWidget('Market Cap', 150),
        onPressed: () {
          sortType = sortNumber;
          isAscending = !isAscending;
          //user.sortName(isAscending);
          setState(() {});
        },
      ),
      FlatButton(
        padding: EdgeInsets.all(0),
        child: _getTitleItemWidget('Price', 110),
        onPressed: () {
          sortType = sortNumber;
          isAscending = !isAscending;
          //user.sortName(isAscending);
          setState(() {});
        },
      ),
      FlatButton(
        padding: EdgeInsets.all(0),
        child: _getTitleItemWidget('Volume', 140),
        onPressed: () {
          sortType = sortNumber;
          isAscending = !isAscending;
          setState(() {});
        },
      ),
      FlatButton(
        padding: EdgeInsets.all(0),
        child: _getTitleItemWidget('1H Change', 100),
        onPressed: () {
          sortType = sortNumber;
          isAscending = !isAscending;
          setState(() {});
        },
      ),
      FlatButton(
        padding: EdgeInsets.all(0),
        child: _getTitleItemWidget('24H Change', 100),
        onPressed: () {
          sortType = sortNumber;
          isAscending = !isAscending;
          setState(() {});
        },
      ),
      FlatButton(
        padding: EdgeInsets.all(0),
        child: _getTitleItemWidget('7D Change', 100),
        onPressed: () {
          sortType = sortNumber;
          isAscending = !isAscending;
          setState(() {});
        },
      ),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      child: Text(
        label,
        style: kHeaderTextStyle,
      ),
      width: width,
      height: 56,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      child: GlowText(
        coinMarketData[index].name,
        style: TextStyle(
          fontFamily: 'LibreBaskerville-Regular',
          fontSize: 14,
          fontWeight: FontWeight.w900,
          color: flutterColor,
        ),
      ),
      width: 100,
      height: 52,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              GlowContainer(
                child: Image.network(
                  coinMarketData[index].image,
                  height: 40.0,
                  width: 40.0,
                ),
                color: Colors.white,
                blurRadius: 19,
              ),
            ],
          ),
          width: 50,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(
            coinMarketData[index].marketCap,
            style: kDataNumberStyle,
          ),
          width: 150,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(
            coinMarketData[index].currentPrice,
            style: kDataNumberStyle,
          ),
          width: 110,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(
            coinMarketData[index].totalVolume,
            style: kDataNumberStyle,
          ),
          width: 140,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(
            coinMarketData[index].oneHourChange,
            style: kDataNumberStyle,
          ),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(
            coinMarketData[index].twoFourHourChange,
            style: kDataNumberStyle,
          ),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(
            coinMarketData[index].sevenDayChange,
            style: kDataNumberStyle,
          ),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }
}

class CoinMarket {
  String name;
  String image;
  String currentPrice;
  String totalVolume;
  String marketCap;
  String oneHourChange;
  String twoFourHourChange;
  String sevenDayChange;

  CoinMarket(
      this.name,
      this.image,
      this.currentPrice,
      this.totalVolume,
      this.marketCap,
      this.oneHourChange,
      this.twoFourHourChange,
      this.sevenDayChange);
}
