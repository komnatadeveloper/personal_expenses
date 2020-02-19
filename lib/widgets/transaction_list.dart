import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return // Transactions Cards
        Container(
          height: 300,
          child: ListView.builder(
            itemBuilder: (ctx, index) {   // ctx for "context", index for List index
              return Card(
                child: Row(
                  children: <Widget>[

                    // Amount
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 2,                        
                        )
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text( 
                        '\$${transactions[index].amount.toStringAsFixed(2)}' ,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).primaryColor
                        ),

                      ),
                    ),

                    // RIGHT SIDE
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget> [
                        Text(
                          transactions[index].title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),  
                        ),
                        Text(
                          // DateFormat('yyyy-MM-dd').format(transactionItem.date) ,   this is also possible with -()dash
                          // DateFormat('yyyy/MM/dd').format(transactionItem.date) ,   "/" between year month etc
                          DateFormat.yMMMd().format(transactions[index].date) ,   // this is a preformatted style
                          style: TextStyle(
                            color: Colors.grey
                          ),  
                        ),
                      ]
                    )
                  ],
                )
              );
            },
            itemCount: transactions.length,          

          ),

        );
  }
}