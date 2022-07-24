import 'package:flutter/material.dart';
import 'models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';
import './widgets/transaction_list.dart' ;


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Manager',
      theme: ThemeData(
        /// primarySwatch: Colors.green ,
        primarySwatch: Colors.purple ,
        /// accentColor: Colors.amber,
        accentColor: Colors.green,
        /// primaryColor: Colors.green,
        backgroundColor: Colors.greenAccent,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        appBarTheme: AppBarTheme(textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
          ), ),
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
/*    Transaction(
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
    ),*/
  ];


  void _addNewTransaction(String txTitle, double txAmount){
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }



  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
      return  GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
      );
    },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// title: Text('Expense Manager', style: TextStyle(fontFamily: 'Open Sans'),),
        title: Text('Expense Manager'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          /// mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                color: Colors.greenAccent,
                child: Container(
                  width: double.infinity,
                  /*child: Text(
                    'Chart!!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.purple,
                    ),
                  ),*/
                  child: Chart(_userTransactions),
                ),
                elevation: 5,
              ),
            ),
            TransactionList(_userTransactions),
          ],
        ),
      ),


      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed:() => _startAddNewTransaction(context),
      ),

    );
  }
}
