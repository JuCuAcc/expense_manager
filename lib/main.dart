import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';
import './widgets/transaction_list.dart';

/// void main() => runApp(MyApp());
void main() {
  /// WidgetsFlutterBinding.ensureInitialized();

  /*SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);*/
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Manager',
      theme: ThemeData(
        /// primarySwatch: Colors.green ,
        primarySwatch: Colors.purple,
        /// accentColor: Colors.amber,
        accentColor: Colors.green,
        /// primaryColor: Colors.green,
        backgroundColor: Colors.greenAccent,
        /// errorColor: Colors.red,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(
                color: Colors.white,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// String titleInput;
  /// String amountInput;

  /*final titleController = TextEditingController();
  final amountController = TextEditingController();*/

  final List<Transaction> _userTransactions = [
  /* Transaction(
      id: 't1',
      title: 'The Checklist Manifesto',
      amount: 17.01,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries ',
      amount: 16.53,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'Jashim Vila',
      amount: 10.99,
      date: DateTime.now(),
    ), */
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,

      /// date: DateTime.now(),
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere(
        (tx) => tx.id == id,
      );
    });
  }


  List<Widget> _buildLandscapeContext(
      MediaQueryData mediaQuery,
      AppBar appBar,
      Widget txListWidget,
      ) {

  return [Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        'Show Chart',
        style: Theme.of(context).textTheme.headline6,
      ),
      Switch.adaptive(
        activeColor: Theme.of(context).accentColor,
        value: _showChart,
        onChanged: (val) {
          setState(() {
            _showChart = val;
          });
        },
      ),
    ],
  ),             _showChart
      ? Container(
      height: (mediaQuery.size.height -
          appBar.preferredSize.height -
          mediaQuery.padding.top) *
          0.7,

      /// child: Chart(_userTransactions)
      child: Chart(_recentTransactions))
      : txListWidget];

  }
  
  List<Widget> _buildPortraitContext(
      MediaQueryData mediaQuery,
      AppBar appBar,
      Widget txListWidget,
      ) {
    return [Container(
        height: (mediaQuery.size.height -
            appBar.preferredSize.height -
            mediaQuery.padding.top) *
            0.3,

        /// child: Chart(_userTransactions)
        child: Chart(_recentTransactions),
    ), txListWidget,];
  }




  @override
  Widget build(BuildContext context) {
    
    print('build() MyHomePageState');
    
    final mediaQuery = MediaQuery.of(context);

    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Expense Manager',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                ),
              ],
            ),
          )
        : AppBar(
            /// title: Text('Expense Manager', style: TextStyle(fontFamily: 'Open Sans'),),
            title: Text('Expense Manager'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
              ),
            ],
          );



    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *

          /// error
          0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );

    print(appBar.preferredSize.height);

    final pageBody = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        /// mainAxisAlignment: MainAxisAlignment.start,

        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (isLandscape)
            ..._buildLandscapeContext(
              mediaQuery,
              appBar,
              txListWidget
          ),
          if (!isLandscape)
           ... _buildPortraitContext(   /// Spread Operator
            mediaQuery,
            appBar,
            txListWidget
          ),

        ],
      ),
    ));

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            resizeToAvoidBottomInset: false,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
          );
  }
}
