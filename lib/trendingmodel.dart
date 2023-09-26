// To parse this JSON data, do
//
//     final trendmodel = trendmodelFromJson(jsonString);

import 'dart:convert';

// Trendmodel trendmodelFromJson(String str) => Trendmodel.fromJson(json.decode(str));

List<Trendmodel> trendmodelFromJson(String str)=>
    List<Trendmodel>.from(json.decode(str).map((x)=>Trendmodel.fromJson(x)));

class Trendmodel {
  String id;
  int coinId;
  String name;
  String symbol;
  int marketCapRank;
  double priceBtc;
  int score;
  String thumb;
  String small;
  String large;

  Trendmodel({
    required this.id,
    required this.coinId,
    required this.name,
    required this.symbol,
    required this.marketCapRank,
    required this.priceBtc,
    required this.score,
    required this.thumb,
    required this.small,
    required this.large,
  });

  factory Trendmodel.fromJson(Map<String, dynamic> json) => Trendmodel(
    id: json["id"],
    coinId: json["coin_id"],
    name: json["name"],
    symbol: json["symbol"],
    marketCapRank: json["market_cap_rank"],
    priceBtc: json["price_btc"]?.toDouble(),
    score: json["score"],
    thumb: json["thumb"],
    small: json["small"],
    large: json["large"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "coin_id": coinId,
    "name": name,
    "symbol": symbol,
    "market_cap_rank": marketCapRank,
    "price_btc": priceBtc,
    "score": score,
    "small": small,
    "large": large,

  };
}
