class Broughtcoin{

String? key;
BroughtcoinData broughtcoinData;
  Broughtcoin({this.key,required this.broughtcoinData});
}
class BroughtcoinData{

  String? name;
  String? quantity;

  BroughtcoinData({this.name, this.quantity});
  BroughtcoinData.fromJson(Map<dynamic,dynamic> json){
    name=json["name"];
    quantity=json["quantity"];
  }
}


class Wallet{
  String? key;

}