/// import 'dart:io';

import 'package:expense_manager/widgets/adaptive_button.dart';
/// import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {

  final Function addTx;

  NewTransaction(this.addTx){
    print('Constructor NewTransaction Widget');
  }

  @override
  State<NewTransaction> createState() {
    print('createState NewTransaction Widget');
    return _NewTransactionState();
  } 
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;


  _NewTransactionState() {
    print('Constructor NewTransaction State');
  }

  @override
  void initState() {
    print('initState()');     /// Call super initState first
    super.initState();
  }



  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    print('didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('dispose()');
    super.dispose();
  }

  void _submitData(){
    if (_amountController.text.isEmpty){
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);


      if(enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null){
        return;
      }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
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
        _selectedDate = pickedDate;
      });
    });
    
    print('Date Chosen');
  }
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(

        child: Container(
          /// padding: EdgeInsets.all(10),
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          /// margin: EdgeInsets.only(bottom: 20,),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              /// CupertinoTextField(placeholder: ,),
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
                        _selectedDate == null
                          ? 'No Date Chosen!'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                      style: TextStyle(color: Colors.green),),
                    ),
                    AdaptiveFlatButton('Chose Date', _presentDatePicker),
                    /*FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text('Choose Date', style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                      onPressed: _presentDatePicker,
                    )*/
                  ],
                ),
              ),

              SizedBox(
                /// height: 50,
                height: 50,
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
      ),
    );
  }
}
