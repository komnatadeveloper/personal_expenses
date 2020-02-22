import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return // Transactions Cards
        Container(
          height: 350,
          child: transactions.isEmpty
           ? 
           Column(
             children: <Widget>[
               Text(
                 'No transaction added yet!',
                 style: Theme.of(context).textTheme.headline6
              ),
              SizedBox( height: 20,),
              Container(
                height: 200,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover
                ),
              )
             ]
           ) 
          
          : 
          ListView.builder(
            itemBuilder: (ctx, index) {   // ctx for "context", index for List index
              
              // instead of Card, we will now use ListTile Widget
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5
                ),

                child: ListTile(

                  leading: FittedBox(
                    child: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                          child: Text('\$${transactions[index].amount.toStringAsFixed(2)}')
                        ),
                      ),
                    ),
                  ),

                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),

                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date) 
                  ),

                  trailing: IconButton( 
                    icon: Icon(Icons.delete), 
                    color: Theme.of(context).errorColor,
                    onPressed: () => deleteTransaction(transactions[index].id),
                  ),
                ),
              );
            },
            itemCount: transactions.length,          

          ),

        );
  }
}





// return Card(
//                 child: Row(
//                   children: <Widget>[

//                     // Amount
//                     Container(
//                       margin: EdgeInsets.symmetric(
//                         vertical: 10,
//                         horizontal: 15
//                       ),
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Theme.of(context).primaryColor,
//                           width: 2,                        
//                         )
//                       ),
//                       padding: EdgeInsets.all(10),
//                       child: Text( 
//                         '\$${transactions[index].amount.toStringAsFixed(2)}' ,
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20,
//                           color: Theme.of(context).primaryColor
//                         ),

//                       ),
//                     ),

//                     // RIGHT SIDE
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget> [

//                         // Title
//                         Text(
//                           transactions[index].title,
//                           style: Theme.of(context).textTheme.headline6
//                         ),

//                         // Date
//                         Text(
//                           // DateFormat('yyyy-MM-dd').format(transactionItem.date) ,   this is also possible with -()dash
//                           // DateFormat('yyyy/MM/dd').format(transactionItem.date) ,   "/" between year month etc
//                           DateFormat.yMMMd().format(transactions[index].date) ,   // this is a preformatted style
//                           style: TextStyle(
//                             color: Colors.grey
//                           ),  
//                         ),

//                       ]
//                     )
//                   ],
//                 )
//               );