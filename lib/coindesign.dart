import 'package:flutter/material.dart';

class CoinDesign extends StatelessWidget {
  CoinDesign({
    Key? key,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.priceChangePercentage24H,
  }) : super(key: key);

  String symbol;
  String name;
  String image;
  double currentPrice;
  double priceChangePercentage24H;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        height: MediaQuery.of(context).size.height / 10,

        decoration: const BoxDecoration(
          color: Colors.transparent,


        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 60,
                width: 60,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.network(image),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      name,
                      style: const TextStyle(
                        color: Color(
                            0xff000000),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    symbol,
                    style: const TextStyle(
                      color: Color(
                          0xff252524),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    currentPrice.toDouble() < 0
                        ? currentPrice.toDouble().toString()
                        : '+${currentPrice.toDouble()}',
                    style: TextStyle(
                      color: currentPrice.toDouble() < 0 ? Colors.red : const Color(
                          0xff252524),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    priceChangePercentage24H.toDouble() < 0
                        ? '${priceChangePercentage24H.toDouble()}%'
                        : '+${priceChangePercentage24H.toDouble()}%',
                    style: TextStyle(
                      color: priceChangePercentage24H.toDouble() < 0
                          ? Colors.red
                          : const Color(
                          0xff252524),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
   
  }
}
