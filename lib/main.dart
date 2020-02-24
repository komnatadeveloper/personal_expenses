import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';




void main()  {

  // WidgetsFlutterBinding.ensureInitialized();

  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
    
  //   DeviceOrientation.portraitDown,    
  // ]).then( ( _ ) => runApp( new MyApp()) );  


  runApp(  MyApp());
  
}

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

  bool _showChart = false;

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
      builder: ( _ ) {
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

    final mediaQuery = MediaQuery.of(context);

    final isLandScape = mediaQuery.orientation == Orientation.landscape;



    final varAppBar = AppBar(
      
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
    );

    final transactionListWidget = Container(
      height: (mediaQuery.size.height 
        - varAppBar.preferredSize.height 
        - mediaQuery.padding.top 
        ) * 0.7,
      child: TransactionList(_userTransactions, _deleteTransaction)
    );



    return Scaffold(

      appBar: varAppBar,

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

          if (isLandScape)  Row(
            mainAxisAlignment: MainAxisAlignment.center,

            // Switch and its Text
            children: <Widget>[
              Text(
                'Show Chart'
              ),
              Switch.adaptive(
                value: _showChart,
                onChanged: (val) {
                  setState(() {
                    _showChart = val;
                  });
                },
              ),
            ],                      
          ),

          if( !isLandScape) Container(
            height: (mediaQuery.size.height - varAppBar.preferredSize.height - mediaQuery.padding.top ) * 0.3 ,
            child: Chart(_recentTransactions)
          ),

          if( !isLandScape) transactionListWidget,

          if( isLandScape) _showChart 
          ? 
          Container(
            height: (mediaQuery.size.height - varAppBar.preferredSize.height - mediaQuery.padding.top ) * 0.7 ,
            child: Chart(_recentTransactions) 
          )
          :
          transactionListWidget
          
          
            
          ],
        ),
      ),

      // Floating Action Button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS 
        ? 
        Container()  // Empty container 
        :  
        FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context)
        ),

    );
  }
}


//test
// test2