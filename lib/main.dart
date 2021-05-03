import 'package:flutter/material.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';

void main() {
  runApp(MaterialApp(
      title: 'Expenses',
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.blueAccent,
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
      home: MyApp()));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Transaction> transaction = [
    // Transaction(
    //   id: 't1',
    //   title: 'new shoes',
    //   cost: 12.00,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'new jeans',
    //   cost: 10.00,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't3',
    //   title: 'new hat',
    //   cost: 5.00,
    //   date: DateTime.now(),
    // ),
  ];
  bool _showChart = false;

  List<Transaction> get _recentTransaction {
    return transaction.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransaction(double cost, String title, DateTime date) {
    setState(() {
      transaction.add(
        Transaction(
          id: transaction.length,
          cost: cost,
          date: date,
          title: title,
        ),
      );
    });
  }

  void _deleteTransaction(int index) {
    setState(() {
      transaction.removeAt(index);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        isScrollControlled: true,
        isDismissible: true,
        builder: (BuildContext cotx) {
          return NewTransaction(_addTransaction);
        });
  }

  List<Widget> landscapeBuilde(Widget chart, Widget transList) {
    return [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('show the Chart '),
        Switch(
            value: _showChart,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            }),
      ]),
      _showChart ? chart : transList,
    ];
  }

  List<Widget> portraitBuilder(Widget chart, Widget transList) {
    return [chart, transList];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(title: Text('expenses'), actions: [
      IconButton(
        icon: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      )
    ]);
    final chart = Container(
      height: isLandscape
          ? (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              0.7
          : (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              0.3,
      child: Chart(_recentTransaction),
    );
    final transList = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TrancationList(
        transaction: transaction,
        deleteFunction: _deleteTransaction,
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isLandscape) ...landscapeBuilde(chart, transList),
          if (!isLandscape) ...portraitBuilder(chart, transList)
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
          ),
          onPressed: () => _startAddNewTransaction(context)),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
