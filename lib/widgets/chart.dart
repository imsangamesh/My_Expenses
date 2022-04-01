import 'package:flutter/material.dart';
import 'package:myexpenses/model/bluetrans.dart';
import '../model/bluetrans.dart';
import 'package:intl/intl.dart';
import '../widgets/chartbar.dart';

class Chart extends StatelessWidget {
  final List<bluetrans> recentTransactions;
  const Chart(this.recentTransactions);

  double get totalSpending {
    return weeklyGeneratedTransactions.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  List<Map<String, Object>> get weeklyGeneratedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0;
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].price;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 17, 10, 10),
      height: (MediaQuery.of(context).size.height -
              AppBar().preferredSize.height -
              40 -
              MediaQuery.of(context).padding.top) *
          0.2,
      child: Card(
        elevation: 7,
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Container(
          color: Colors.pink[100],
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...weeklyGeneratedTransactions.map((data) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    data['day'].toString(),
                    (data['amount'] as double),
                    totalSpending == 0
                        ? 0
                        : (data['amount'] as double) / totalSpending,
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
