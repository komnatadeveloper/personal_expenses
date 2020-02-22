import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';




void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        errorColor: Colors.red,  // actually it is already as default: Colors.red
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(

          headline6: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),

          button: TextStyle(
            color: Colors.white
          )
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold
            )
          )
        )
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  // String titleInput;
  // String amountInput;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id:'t1',
    //   title:'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now()
    // ),
    // Transaction(
    //   id:'t2',
    //   title:'Weekly Groceries',
    //   amount: 16.53,
    //   date: DateTime.now()
    // ),
  ];

  List<Transaction> get _recentTransactions {

    return _userTransactions.where((transaction) {
      return transaction.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7)
        )
      );
    }).toList();
  }

  void _addNewTransaction (String transactionTitle, double transactionAmount, DateTime chosenDate) {
    final newTransactionItem = Transaction(
      id: DateTime.now().toString(), 
      title: transactionTitle, 
      amount: transactionAmount, 
      date: chosenDate
    );

    setState(() {
      _userTransactions.add(newTransactionItem);
    });
  }

  void _startAddNewTransaction( BuildContext ctx ) {
    showModalBottomSheet(
      context: ctx, 
      builder: (bCtx) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        ) ;
      }
    );
  }

  void _deleteTransaction ( String id) {
    setState(() {
      _userTransactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        
        title: Text(
            'Personal Expenses',
            // style: TextStyle(fontFamily: 'OpenSans'),
          ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add, ),
            onPressed: () => _startAddNewTransaction(context)
          )
        ],
        
      ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          
          children: <Widget>[

          // Chart
          // Container(
          //   width: double.infinity,
          //   child: Card(
          //     color: Colors.blue,
          //     child: Text('CHART'),              
          //     elevation: 5,
          //   ),
          // ), 
          Chart(_recentTransactions),

          TransactionList(_userTransactions, _deleteTransaction)
          
            
          ],
        ),
      ),

      // Floating Action Button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context)
      ),

    );
  }
}
