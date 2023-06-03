// To parse this JSON data, do
//
//     final coinmodel = coinmodelFromJson(jsonString);



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

}
 List<Coinmodel> coinList=[];