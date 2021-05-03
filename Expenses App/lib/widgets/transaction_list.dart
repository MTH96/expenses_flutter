import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TrancationList extends StatelessWidget {
  TrancationList({this.transaction, this.deleteFunction});
  final List<Transaction> transaction;
  final Function deleteFunction;
  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? Column(
            children: [
              Text('There is no data yet!'),
              Expanded(child: Image.asset('assets/images/waiting.png')),
            ],
          )
        : ListView.builder(
            itemCount: transaction.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 6,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).accentColor,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: FittedBox(
                        child: Text(
                          '\$ ${transaction[index].cost}',
                          style: ThemeData.dark().accentTextTheme.headline6,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    transaction[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transaction[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 400
                      ? TextButton.icon(
                          onPressed: () {
                            deleteFunction(index);
                          },
                          icon: Icon(Icons.delete),
                          label: Text('Delete'))
                      : TextButton(
                          child: Icon(Icons.delete),
                          onPressed: () {
                            deleteFunction(index);
                          },
                        ),
                ),
              );
            },
          );
  }
}
