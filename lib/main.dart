import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/chart.dart';
import 'package:personal_expenses/widgets/list.dart';
import 'package:personal_expenses/widgets/userinput.dart';
import 'models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Transaction> transactions = [
    Transaction(id: 1, title: 'Shoes', amount: 134.5, date: DateTime.now()),
    Transaction(id: 2, title: 'Shirt', amount: 139.5, date: DateTime.now())
  ];

  void addTransaction(String title_, double amount_, DateTime date_) {
    setState(() {
      transactions.add(Transaction(
          id: transactions.length + 1,
          title: title_,
          amount: amount_,
          date: date_));
    });
  }

  void startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return UserInput(addTransaction);
        });
  }

  void deleteTransaction(int id_) {
    setState(() {
      transactions.removeWhere((transaction) => transaction.id == id_);
    });
  }

  List<Transaction> get getRecentTransaction {
    return transactions.where((transaction) {
      return transaction.date!
          .isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expense App',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          textTheme: ThemeData.light()
              .textTheme
              .copyWith(headline6: const TextStyle(fontSize: 26))),
      home: Builder(builder: (context) {
        return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Personal Expenses',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                    onPressed: () => startNewTransaction(context),
                    icon: const Icon(Icons.add))
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Chart(getRecentTransaction),
                  ListComponent(transactions, deleteTransaction),
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Theme.of(context).accentColor,
              onPressed: () => startNewTransaction(context),
              child: const Icon(Icons.add),
            ));
      }),
    );
  }
}
