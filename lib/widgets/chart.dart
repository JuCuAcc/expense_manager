
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './chart_bar.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupTransactionValues {
  
  return List.generate(7, (index) {
    final weekDay = DateTime.now().subtract(
      Duration(days: index),
    );

    var totalSum = 0.0;

    var rl = recentTransactions.length;

    for(var i = 0; i < rl; i++){
      if(recentTransactions[i].date.day == weekDay.day &&
          recentTransactions[i].date.month == weekDay.month &&
          recentTransactions[i].date.year == weekDay.year){
            totalSum += recentTransactions[i].amount;
      }
    };

    /*print(DateFormat.E(weekDay));
    print(totalSum);*/

    return {
      'day': DateFormat.E().format(weekDay).substring(0, 1),
      'amount': totalSum,
    };
  }).reversed.toList();
}

double get totalSpending {
  return groupTransactionValues.fold(0.0, (sum, item) {
    return sum + item['amount'];
  });
}

  @override
  Widget build(BuildContext context) {
    print(recentTransactions.length);
    return Card(elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupTransactionValues.map((data) {
           /// return Text(data['day'] + ' : ' + data['amount'].toString(),);
            /// return Text('${data['day']}: ${data['amount']}');
            return Flexible(
              /// flex: 2,
              fit: FlexFit.tight,
              child: ChartBar(
                  data['day'],
                  data['amount'],
                  totalSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double)/ totalSpending
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}