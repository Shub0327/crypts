// To parse this JSON data, do
//
//     final coinmodel = coinmodelFromJson(jsonString);
import 'dart:convert';


List<Coinmodel> CoinmodelFromJson(String str)=>
    List<Coinmodel>.from(json.decode(str).map((x)=>Coinmodel.fromJson(x)));

// Coinmodel CoinmodelFromJson(String str) => Coinmodel.fromJson(json.decode(str));


String coinmodelToJson(Coinmodel data) => json.encode(data.toJson());


class Coinmodel {
  String id;
  String symbol;
  String name;
  String image;
  double currentPrice;
  double priceChangePercentage24H;

  Coinmodel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.priceChangePercentage24H,
  });

  factory Coinmodel.fromJson(Map<String, dynamic> json) => Coinmodel(
    id: json["id"],
    symbol: json["symbol"],
    name: json["name"],
    image: json["image"],
    currentPrice: json["current_price"].toDouble() ,
    priceChangePercentage24H: json["price_change_percentage_24h"].toDouble() ,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "symbol": symbol,
    "name": name,
    "image": image,
    "current_price": currentPrice,
    "price_change_percentage_24h": priceChangePercentage24H,
  };

}
 List<Coinmodel> coinList=[];