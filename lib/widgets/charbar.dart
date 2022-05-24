import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String date;
  final double amount;
  final double percentageOfTotal;

  ChartBar(
      {required this.date,
      required this.amount,
      required this.percentageOfTotal});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constrains) {
      return Container(
        child: Column(children: [
          Container(
              height: constrains.maxHeight * 0.15,
              child: FittedBox(
                child: Text('\$${amount.toStringAsFixed(2)}'),
              )),
          SizedBox(
            height: 4,
          ),
          Container(
              height: constrains.maxHeight * 0.6,
              width: 10,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromRGBO(220, 220, 220, 1),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: percentageOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              )),
          SizedBox(
            height: constrains.maxHeight * 0.05,
          ),
          Container(
            height: constrains.maxHeight * 0.15,
            child: Text(date),
          ),
        ]),
      );
    });
  }
}
