import 'package:flutter/material.dart';

class TrendDesign extends StatelessWidget {
  TrendDesign({
    Key? key,
    required this.symbol,
    required this.coinId,
    required this.name,
    required this.small,
    required this.priceBtc,
    required this.score,
    required this.marketCapRank,
  }) : super(key: key);

  double coinId;
  String symbol;
  String name;
  String small;
  double priceBtc;
  double marketCapRank;
  double score;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        height: MediaQuery.of(context).size.height / 9,

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
                  child: Image.network(small),
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
                      'ID-$coinId',
                      style: const TextStyle(
                        color: Color(
                            0xff000000),
                        fontSize: 10,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
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
                     '#${score.toDouble()+1}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    priceBtc.toDouble() < 0
                        ? priceBtc.toDouble().toStringAsFixed(10)
                        : '${priceBtc.toDouble().toStringAsFixed(10)} BTC',
                    style: TextStyle(
                      color: priceBtc.toDouble() < 0 ? Colors.red : Colors.green,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                   'Market Rank ${marketCapRank.toDouble()}',
                    style: const TextStyle(
                      color: Colors.black,
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
