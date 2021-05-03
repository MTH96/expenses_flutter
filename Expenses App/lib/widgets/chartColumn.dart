import 'package:flutter/material.dart';

class ChartColumn extends StatelessWidget {
  final double cost;
  final String day;
  final double presentage;

  ChartColumn(this.cost, this.day, this.presentage);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        children: [
          Container(
              height: constraints.maxHeight * .15,
              child: FittedBox(
                  child: Text(
                '\$${cost.floor()}',
              ))),
          Container(
            height: constraints.maxHeight * .70,
            width: 15,
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Colors.grey[500],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[300],
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: presentage,
                  child: Container(
                    // height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(child: Text(day)))
        ],
      ),
    );
  }
}
