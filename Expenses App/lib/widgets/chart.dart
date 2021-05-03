import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import './chartColumn.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get chartData {
    return List.generate(7, (index) {
      final day = DateTime.now().subtract(Duration(days: index));
      double amount = 0.0;
      for (Transaction transaction in recentTransactions) {
        if (transaction.date.day == day.day &&
            transaction.date.month == day.month &&
            transaction.date.year == day.year) amount += transaction.cost;
      }

      return {
        'day': DateFormat.E().format(day),
        'amount': amount,
      };
    }).reversed.toList();
  }

  double get totalAmount {
    double sum = 0.0;
    for (Transaction transaction in recentTransactions) {
      sum += transaction.cost;
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
            children: chartData.map((element) {
          return Expanded(
            child: ChartColumn(
                element['amount'],
                element['day'],
                recentTransactions.isEmpty
                    ? 0.0
                    : (element['amount'] as double) / totalAmount),
          );
        }).toList()),
      ),
    );
  }
}
