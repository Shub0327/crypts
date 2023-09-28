import 'dart:convert';


List<Trendmodel> TrendmodelFromJson(String str)=> List<Trendmodel>.from(json.decode(str).map((x)=>Trendmodel.fromJson(x)));


String trendmodelToJson(Trendmodel data) => json.encode(data.toJson());

class Trendmodel {
  List<Coin> coins;

  Trendmodel({
    required this.coins,
  });

  factory Trendmodel.fromJson(Map<String, dynamic> json) => Trendmodel(
    coins: List<Coin>.from(json["coins"].map((x) => Coin.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "coins": List<dynamic>.from(coins.map((x) => x.toJson())),
  };
}

class Coin {
  Item item;

  Coin({
    required this.item,
  });

  factory Coin.fromJson(Map<String, dynamic> json) => Coin(
    item: Item.fromJson(json["item"]),
  );

  Map<String, dynamic> toJson() => {
    "item": item.toJson(),
  };
}

class Item {
  String id;
  double coinId;
  String name;
  String symbol;
  double marketCapRank;
  String small;
  double priceBtc;
  double score;

  Item({
    required this.id,
    required this.coinId,
    required this.name,
    required this.symbol,
    required this.marketCapRank,
    required this.small,
    required this.priceBtc,
    required this.score,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    coinId: json["coin_id"]?.toDouble(),
    name: json["name"],
    symbol: json["symbol"],
    marketCapRank: json["market_cap_rank"]?.toDouble(),
    small: json["small"],
    priceBtc: json["price_btc"]?.toDouble(),
    score: json["score"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "coin_id": coinId,
    "name": name,
    "symbol": symbol,
    "market_cap_rank": marketCapRank,
    "small": small,
    "price_btc": priceBtc,
    "score": score,
  };
}
