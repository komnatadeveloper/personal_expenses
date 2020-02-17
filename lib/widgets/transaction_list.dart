import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return // Transactions Cards
        Column(
          children: _userTransactions.map( (transactionItem) {
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
                        color: Colors.purple,
                        width: 2,                        
                      )
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text( 
                      '\$${transactionItem.amount}' ,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.purple
                      ),

                    ),
                  ),

                  // RIGHT SIDE
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget> [
                      Text(
                        transactionItem.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),  
                      ),
                      Text(
                        // DateFormat('yyyy-MM-dd').format(transactionItem.date) ,   this is also possible with -()dash
                        // DateFormat('yyyy/MM/dd').format(transactionItem.date) ,   "/" between year month etc
                        DateFormat.yMMMd().format(transactionItem.date) ,   // this is a preformatted style
                        style: TextStyle(
                          color: Colors.grey
                        ),  
                      ),
                    ]
                  )
                ],
              )
            );
          }).toList()
        );
  }
}