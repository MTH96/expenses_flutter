import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function newTransaction;
  NewTransaction(this.newTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime date;

  void submitData() {
    double txAmount = double.parse(amountController.text);
    String txTitle = titleController.text;
    if (txTitle.isEmpty || txAmount <= 0 || date == null) return;

    widget.newTransaction(txAmount, txTitle, date);
    titleController.clear();
    amountController.clear();
    Navigator.pop(context);
  }

  void _startDatePicker() async {
    var temp = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    );
    setState(() {
      date = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 15,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
                keyboardType: TextInputType.text,
              ),
              TextField(
                  controller: amountController,
                  decoration: InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) {
                    submitData();
                  }),
              Row(
                children: [
                  Expanded(
                    child: Text(date == null
                        ? 'no date entered yet!'
                        : DateFormat.MEd().format(date)),
                  ),
                  TextButton(
                    onPressed: _startDatePicker,
                    child: Text('Date Picker'),
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  submitData();
                },
                child: Text(
                  'Add Transaction',
                  style: ThemeData.dark().textTheme.headline6,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
