import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {

  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData () {
    final enteredTitle = titleController.text;
    if(amountController.text.length == 0) {
      return;
    }
    final enteredAmount = double.parse(amountController.text) ;


    if(enteredTitle.isEmpty || enteredAmount <= 0 ) {
      return;
    }


    widget.addTransaction(
      enteredTitle, 
      enteredAmount
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget> [
            TextField(
              decoration: InputDecoration(
                labelText: 'Title'
              ),
              // onChanged: ( val ) {
              //   titleInput = val;
              // },
              controller: titleController,
              onSubmitted: ( _ ) => submitData(),
            ),

            // Amount
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount'
              ),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: ( _ ) => submitData(),
            ),

            // Button
            FlatButton(
              textColor: Colors.purple,
              child: Text('Add Transaction'),
              onPressed: submitData
            )
          ]
        )
      )
    );
  }
}