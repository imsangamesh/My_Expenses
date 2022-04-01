import 'package:flutter/material.dart';
import './widgets/chart.dart';
import './widgets/inputs.dart';
import './model/bluetrans.dart';
import './widgets/transasctionlist.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'my Expenses',
      home: MyExpenses(),
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: const Color.fromRGBO(255, 222, 240, 1),
        fontFamily: 'Quicksand',
      ),
      color: Colors.pink,
    );
  }
}

class MyExpenses extends StatefulWidget {
  @override
  State<MyExpenses> createState() => _MyAppState();
}

class _MyAppState extends State<MyExpenses> {
  bool showChart = false;
  void deleteHandler(String id) {
    setState(() {
      transactions.removeWhere((tx) => tx.id == id);
    });
  }

  void addtransaction(String title, double price, DateTime date) {
    Navigator.of(context).pop();
    // if(isEmpty(price)){}
    if (title.isEmpty || price <= 0 || date == null) {
      return;
    } else {
      final newtranc = bluetrans(
        title,
        price,
        date,
        DateTime.now().toString(),
      );
      setState(() {
        transactions.add(newtranc);
      });
    }
  }

  List<bluetrans> transactions = [];

  void showModal(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          child: Inputs(addtransaction),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  List<bluetrans> get recentTransactions {
    return transactions
        .where((tx) => tx.date.isAfter(
              DateTime.now().subtract(const Duration(days: 7)),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appbar = AppBar(
      backgroundColor: Colors.pinkAccent,
      title: const Text(
        'MyExpenses ',
        style: TextStyle(
          fontFamily: 'Quicksand',
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => showModal(context),
          icon: const Icon(Icons.add),
        )
      ],
    );
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    showChart == true ? 'show Transactions' : 'show Chart',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  Switch(
                      value: showChart,
                      onChanged: (changedValue) => setState(() {
                            showChart = changedValue;
                          }))
                ],
              ),
            if (isLandscape)
              showChart
                  ? Chart(recentTransactions)
                  : TransactionList(transactions, deleteHandler),
            if (!isLandscape) Chart(recentTransactions),
            if (!isLandscape) TransactionList(transactions, deleteHandler),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        hoverColor: Colors.amber[200],
        onPressed: () {
          showModal(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
