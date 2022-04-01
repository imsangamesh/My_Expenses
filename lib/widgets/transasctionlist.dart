import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/bluetrans.dart';

class TransactionList extends StatelessWidget {
  final List<bluetrans> transactions;
  final Function deleteHandler;
  const TransactionList(this.transactions, this.deleteHandler);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height -
              AppBar().preferredSize.height -
              60 -
              MediaQuery.of(context).padding.top) *
          0.767,
      margin: const EdgeInsets.fromLTRB(4, 14, 4, 6),
      child: transactions.isNotEmpty
          ? Card(
              color: const Color.fromRGBO(255, 186, 211, 0.9),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),

                width: double.infinity,
                // height: (MediaQuery.of(context).size.height -
                //         AppBar().preferredSize.height -
                //         MediaQuery.of(context).padding.top) *
                //     0.8,
                child: ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (context, index) => Card(
                    elevation: 6,
                    child: ListTile(
                      selectedColor: Colors.blue,
                      tileColor: Colors.amber[300],
                      hoverColor: Colors.green,
                      leading: CircleAvatar(
                        backgroundColor: Colors.pink,
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: FittedBox(
                              child: Text(
                            '\$${transactions[index].price}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        ),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date),
                      ),
                      trailing: MediaQuery.of(context).size.width >= 350
                          ? TextButton.icon(
                              icon: const Icon(Icons.delete),
                              label: const Text('Delete'),
                              onPressed: () =>
                                  deleteHandler(transactions[index].id),
                            )
                          : IconButton(
                              color: Theme.of(context).errorColor,
                              icon: const Icon(Icons.delete),
                              onPressed: () =>
                                  deleteHandler(transactions[index].id),
                            ),
                    ),
                  ),
                ),
              ),
            )
          : LayoutBuilder(builder: (context, constraints) {
              return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 3),
                  width: double.infinity,
                  // height: (MediaQuery.of(context).size.height -
                  //         AppBar().preferredSize.height -
                  //         MediaQuery.of(context).padding.top) *
                  //     0.8,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'no transactions to show ! ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Quicksand',
                            fontSize: 22,
                          ),
                        ),
                      ),
                      Container(
                        height: constraints.maxHeight * 0.5,
                        child: Image.asset(
                          'assets/images/waiting.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ));
            }),
    );
  }
}
