import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {

  Color _bgColor;

  @override
  void initState() {
    
    const availableColors = [Colors.red, Colors.blue, Colors.orange, Colors.pink];

    _bgColor = availableColors[
      Random().nextInt(4)  // Random number between 0 and 3
    ]; 

    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5
      ),

      child: ListTile(

        leading: FittedBox(
          child: CircleAvatar(
            backgroundColor: _bgColor,
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: FittedBox(
                child: Text('\$${widget.transaction.amount.toStringAsFixed(2)}')
              ),
            ),
          ),
        ),

        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),

        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date) 
        ),

        trailing: MediaQuery.of(context).size.width > 460 
        ?
        FlatButton.icon(
          textColor: Theme.of(context).errorColor,
          onPressed: () =>  widget.deleteTransaction(widget.transaction.id), 
          icon: const Icon(Icons.delete), 
          label: const Text('Delete')
        ) 
        : 
        IconButton( 
          icon: const  Icon(Icons.delete), 
          color: Theme.of(context).errorColor,
          onPressed: () => widget.deleteTransaction(widget.transaction.id),
        ),
      ),
    );
  }
}