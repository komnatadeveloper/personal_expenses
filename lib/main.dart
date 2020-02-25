import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  List <Widget> _buildLandscapeContent(
    MediaQueryData mediaQuery, 
    AppBar varAppBar, 
    Container transactionListWidget
    ) {

    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,

        // Switch and its Text
        children: <Widget>[
          Text(
            'Show Chart',
            style: Theme.of(context).textTheme.headline6
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
      _showChart 
          ? 
          Container(
            height: (mediaQuery.size.height - varAppBar.preferredSize.height - mediaQuery.padding.top ) * 0.7 ,
            child: Chart(_recentTransactions) 
          )
          :
          transactionListWidget
    ];
    
  }
  List<Widget> _buildLPortraitContent(
    MediaQueryData mediaQuery, 
    AppBar varAppBar, 
    Container transactionListWidget
    ) {
    return [
      Container(
        height: (mediaQuery.size.height 
          - varAppBar.preferredSize.height 
          - mediaQuery.padding.top 
          ) * 0.3 ,
        child: Chart(_recentTransactions)
      ), 
      transactionListWidget
    ];
  }

  Widget _iosbuildContent( 
    PreferredSizeWidget varAppBar, 
    Widget pageBody 
  ) {
    return CupertinoPageScaffold(
        navigationBar: varAppBar,
        child: pageBody
      );
  }

  Widget _androidbuildContent(
    PreferredSizeWidget varAppBar, 
    Widget pageBody 
  ) {
    return Scaffold(

      appBar: varAppBar,

      body: pageBody,

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

  Widget _buildAppBar () {
    return Platform.isIOS 

      // for IOS NavigationBar
      ? CupertinoNavigationBar(
        middle: Text(
            'Personal Expenses',
            // style: TextStyle(fontFamily: 'OpenSans'),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[

              GestureDetector(
                child: Icon(CupertinoIcons.add ),
                onTap: () => _startAddNewTransaction(context)
              ),

            ],
          ),

      ) 


      // for Android AppBar
      : AppBar(      
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

  }


  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context);
    final isLandScape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget varAppBar = _buildAppBar();

    final transactionListWidget = Container(
      height: (mediaQuery.size.height 
        - varAppBar.preferredSize.height 
        - mediaQuery.padding.top 
        ) * 0.7,
      child: TransactionList(_userTransactions, _deleteTransaction)
    );

    final pageBody = SafeArea(
      child: SingleChildScrollView(
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

          if (isLandScape)  ..._buildLandscapeContent(
            mediaQuery, 
            varAppBar,
            transactionListWidget
          ),

          if( !isLandScape) ..._buildLPortraitContent(
            mediaQuery, 
            varAppBar,
            transactionListWidget
          ),
          
          
            
          ],
        ),
      )
    ) ;



    return Platform.isIOS 
      ? 
      _iosbuildContent( varAppBar, pageBody ) 
      : 
      _androidbuildContent( varAppBar, pageBody );
      
  }
}


//test
// test2