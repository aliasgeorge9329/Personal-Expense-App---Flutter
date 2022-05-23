import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserInput extends StatefulWidget {
  final Function addTransaction;
  UserInput(this.addTransaction);

  @override
  State<UserInput> createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  final titlecontroller = TextEditingController();
  final amountcontroller = TextEditingController();
  DateTime? dateChosen;

  void submitData() {
    final String title = titlecontroller.text;
    final double amount = double.parse(amountcontroller.text);

    if (title.isEmpty || amount <= 0) {
      return;
    }

    widget.addTransaction(
      titlecontroller.text,
      double.parse(amountcontroller.text),
      dateChosen,
    );

    Navigator.pop(context);
  }

  void visibleDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((datePicked) {
      if (datePicked == null) {
        return;
      }
      setState(() {
        dateChosen = datePicked;
        submitData();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: Card(
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  controller: titlecontroller,
                  onSubmitted: (_) => submitData(),
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Amount'),
                  controller: amountcontroller,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onSubmitted: (_) => submitData(),
                ),
                Container(
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(dateChosen == null
                            ? 'No Date Chosen'
                            : 'Picked Date: ' +
                                DateFormat.yMd()
                                    .format(dateChosen as DateTime)),
                      ),
                      TextButton(
                          onPressed: visibleDatePicker,
                          child: const Text(
                            'Choose Date',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: submitData,
                  child: const Text(
                    'Add Transaction',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
