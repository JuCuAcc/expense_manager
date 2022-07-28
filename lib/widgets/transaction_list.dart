import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function  deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty ? LayoutBuilder(builder: (ctx, constraints){
      return Column(
        children: <Widget>[
          Text('No Transactions Added Yet!',
            style: Theme.of(context).textTheme.headline6, /// title = headline6
          ),

          const SizedBox(
            height: 20,
          ),

          Container(
              /// height: 200,
              height: constraints.maxHeight * 0.6,
              child: Image.asset(
                'assets/images/waiting.png',
                fit: BoxFit.cover,
              )
          ),
        ],
      );
    })
        : ListView.builder(
      itemBuilder: (ctx, index) {

        /// return ListTile(leading: CircleAvatar(radius: 30, child: Text('\$${}'),),);
        return TransactionItem(index, context);
      },
      itemCount: transactions.length ,
    );
  }

  Card TransactionItem(int index, BuildContext context) {
    return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 5,
        ),
        child: ListTile(
          leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text('৳${transactions[index].amount}'
              ),
            ),
          ),
        ),
          title: Text(transactions[index].title,
            style: Theme.of(context).textTheme.headline6,),
          subtitle: Text(
             DateFormat.yMMMd().format(transactions[index].date),
          ),
          trailing: MediaQuery.of(context).size.width > 360
              ? FlatButton.icon(
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete'),
                  /// text: Theme.of(context).errorColor,
                  textColor: Theme.of(context).errorColor,
                  onPressed: () => deleteTx(transactions[index].id) ,

          )
              : IconButton(
            icon: const Icon(Icons.delete),
            color: Theme.of(context).errorColor,
            onPressed: () => deleteTx(transactions[index].id) ,
          ),
        ),
      );
  }
}
