// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Inputs extends StatefulWidget {
  final Function addtransaction;
  Inputs(this.addtransaction);

  @override
  State<Inputs> createState() => _InputsState();
}

class _InputsState extends State<Inputs> {
  var pickedDate = null;
  final titlecontroller = TextEditingController();
  final pricecontroller = TextEditingController();

  void openDatePicker(context) {
    showDatePicker(
      confirmText: 'CONFIRM',
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate == null) return;
      setState(() {
        pickedDate = selectedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(255, 222, 240, 1),
      padding: EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
        bottom: (MediaQuery.of(context).viewInsets.bottom) + 10,
      ),
      child: SingleChildScrollView(
        child: Card(
          elevation: 6,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Color.fromRGBO(255, 222, 240, 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(5),
                    labelText: 'enter the title',
                  ),
                  controller: titlecontroller,
                ),
                TextField(
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(5),
                    labelText: 'enter the amount',
                  ),
                  controller: pricecontroller,
                  keyboardType: TextInputType.number,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 10,
                  ),
                  child: Row(children: [
                    Expanded(
                      child: Text(
                        pickedDate == null
                            ? 'please choose date'
                            : 'Date chosen : ${DateFormat.yMd().format(pickedDate)}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () => openDatePicker(context),
                      icon: const Icon(
                        Icons.date_range,
                        color: Colors.pink,
                      ),
                      label: const Text('Date',
                          style: TextStyle(
                            color: Colors.pink,
                          )),
                    )
                  ]),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  width: double.infinity,
                  child: RaisedButton(
                    color: Colors.pinkAccent,
                    disabledColor: Colors.amber[100],
                    textColor: Colors.white,
                    onPressed: (pickedDate != null &&
                            titlecontroller.text != null &&
                            pricecontroller.text != null)
                        ? () {
                            double sentamount = 0;
                            pricecontroller.text.isEmpty
                                ? sentamount = 0
                                : sentamount =
                                    double.parse(pricecontroller.text);
                            widget.addtransaction(
                              titlecontroller.text,
                              sentamount,
                              pickedDate,
                            );
                          }
                        : null,
                    child: const Text('Add transaction'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
