import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {

  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _seectedDate;

  void _submitData(){
    if (_amountController.text.isEmpty){
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);


      if(enteredTitle.isEmpty || enteredAmount <= 0 || _seectedDate == null){
        return;
      }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _seectedDate,
    );

      Navigator.of(context).pop();

  }

  void _presentDatePicker(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime.now(),
    ).then((pickedDate) {
      if(pickedDate == null){
        return;
      }
      setState(() {
      _seectedDate = pickedDate;
      });
    });
    
    print('Date Chosen');
  }
  
  @override
  Widget build(BuildContext context) {
    return Card(

      child: Container(
        padding: EdgeInsets.all(10),
        /// margin: EdgeInsets.only(bottom: 20,),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[

            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
              /*onChanged:  (val) {
                titleInput = val;
              },*/
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),



              /// onChanged: (val) => amountInput = val,
            ),
            /// TextField(),

            Container(
             // height: 70,
              height: 90,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _seectedDate == null
                        ? 'No Date Chosen!'
                        : 'Picked Date: ${DateFormat.yMd().format(_seectedDate)}',
                    style: TextStyle(color: Colors.green),),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text('Choose Date', style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                    onPressed: _presentDatePicker,
                  )
                ],
              ),
            ),

            SizedBox(
              /// height: 50,
              height: 100,
              width: 200,

              /// child: FlatButton(
              child: RaisedButton(
                child: Text('Add Transaction'),
               /// color: Colors.purple,
                color: Theme.of(context).primaryColor,
                /// textColor: Colors.white,
                textColor: Theme.of(context).textTheme.button.color,

                onPressed: _submitData,
              ),
            ),
          ],
        ),
      ),
      elevation: 5,
    );
  }
}
