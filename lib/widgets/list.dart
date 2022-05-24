import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:intl/intl.dart';

class ListComponent extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  ListComponent(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        height: MediaQuery.of(context).size.height * 0.6,
        child: transactions.isNotEmpty
            ? ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: FittedBox(
                            child: Text(
                              '\$${transactions[index].amount}',
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        transactions[index].title as String,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd()
                            .format(transactions[index].date as DateTime),
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            deleteTransaction(transactions[index].id);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                    ),
                  );
                },
                itemCount: transactions.length)
            : Column(
                children: [
                  Text(
                    'No Transaction Yet',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 300,
                    child: Center(
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ));
    ;
  }
}
