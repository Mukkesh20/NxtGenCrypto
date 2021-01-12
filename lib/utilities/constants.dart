import 'package:flutter/material.dart';

const kDataTextStyle = TextStyle(
  fontFamily: 'LibreBaskerville-Regular',
  fontSize: 14.0,
  fontWeight: FontWeight.bold,
  color: Colors.lightGreen,
);

const kHeaderTextStyle = TextStyle(
  fontFamily: 'LibreBaskerville-Regular',
  fontSize: 15.0,
  fontWeight: FontWeight.bold,
  color: Colors.white70,
);

const kDropdownTextStyle = TextStyle(
  fontFamily: 'LibreBaskerville-Regular',
  fontSize: 17.0,
  fontWeight: FontWeight.w500,
  color: Colors.black,
);

const kDataNumberStyle = TextStyle(
  fontFamily: 'LibreBaskerville-Regular',
  fontSize: 14.0,
  fontWeight: FontWeight.w600,
  color: Colors.deepOrange,
);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: 'Enter City Name',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide.none,
  ),
);

const List<dynamic> kCurrencyList = [
  "btc",
  "eth",
  "ltc",
  "bch",
  "bnb",
  "eos",
  "xrp",
  "xlm",
  "link",
  "dot",
  "yfi",
  "usd",
  "aed",
  "ars",
  "aud",
  "bdt",
  "bhd",
  "bmd",
  "brl",
  "cad",
  "chf",
  "clp",
  "cny",
  "czk",
  "dkk",
  "eur",
  "gbp",
  "hkd",
  "huf",
  "idr",
  "ils",
  "inr",
  "jpy",
  "krw",
  "kwd",
  "lkr",
  "mmk",
  "mxn",
  "myr",
  "ngn",
  "nok",
  "nzd",
  "php",
  "pkr",
  "pln",
  "rub",
  "sar",
  "sek",
  "sgd",
  "thb",
  "try",
  "twd",
  "uah",
  "vef",
  "vnd",
  "zar",
  "xdr",
  "xag",
  "xau"
];
