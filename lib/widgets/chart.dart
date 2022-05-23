import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/widgets/charbar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;

  Chart(this.transactions);

  List<Map<String, Object>> get groupedTransaction {
    var totalSum = 0.0;

    for (var each in transactions) {
      totalSum += each.amount!;
    }

    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var totalWeekSum = 0.0;

      for (var transaction in transactions) {
        if (transaction.date?.day == weekDay.day &&
            transaction.date?.month == weekDay.month &&
            transaction.date?.year == weekDay.year) {
          totalWeekSum += transaction.amount!;
        }
      }

      return {
        'weekDay': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalWeekSum,
        'percentage': transactions.isEmpty ? 0.0 : (totalWeekSum / totalSum),
      };
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 20),
      child: Card(
        color: Colors.white,
        elevation: 6,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...groupedTransaction.map((eachDayData) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: ChartBar(
                        date: eachDayData['weekDay'] as String,
                        amount: eachDayData['amount'] as double,
                        percentageOfTotal: eachDayData['percentage'] as double),
                  ),
                );
              }).toList()
            ],
          ),
        ),
      ),
    );
  }
}
