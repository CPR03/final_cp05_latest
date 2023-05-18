
import 'package:final_cp05/functionn/expensessave.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../theme/colors.dart';

class NewExpense extends StatefulWidget {
  final Function(String, double, DateTime) addExpense;

  NewExpense(this.addExpense);

  @override
  NewExpenseState createState() => NewExpenseState();
}


class NewExpenseState extends State<NewExpense> {

  //for getting the values from the text and date field
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _sumController = TextEditingController();
  static double total = 0.0;
  DateTime? _selectedDate;

  //function that will submit the data to its caller
  void submitData() {

    final enteredTitle = _titleController.text;
    final enteredAmount = double.tryParse(_amountController.text);

    //total += enteredAmount!;
    //_amountController.clear();
    _sumController.text = total.toString();

    if (enteredTitle.isEmpty || _selectedDate == null) {
      return;
    }

    widget.addExpense(enteredTitle, enteredAmount!, _selectedDate!);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: TextFormField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                    label: Text("Name",style: TextStyle(color: Colors.black.withOpacity(0.3), fontWeight: FontWeight.bold),),

                    enabledBorder: const OutlineInputBorder(

                        borderSide: BorderSide(
                            width: 3,
                            color: mainFontColor

                        )
                    )
                ),

                controller: _titleController,
              ),
            ),

            const SizedBox(height: 15,),

            SizedBox(

              width: 300,
              child: TextFormField(

                decoration: InputDecoration(
                    label: Text("Amount",style: TextStyle(color: Colors.black.withOpacity(0.3), fontWeight: FontWeight.bold),),

                    enabledBorder: const OutlineInputBorder(

                        borderSide: BorderSide(
                            width: 3,
                            color: mainFontColor

                        )
                    )
                ),

                controller: _amountController,
                keyboardType: TextInputType.number,
              ),
            ),


            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No Date has been set!'
                        : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}',
                  ),
                ),

                TextButton(
                  onPressed: _presentDatePicker,
                  child: const Text(
                    'Choose a Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            //add button
            ElevatedButton(
              onPressed: submitData,
              child: const Text('Add Expense'),
            ),
          ],
        ),
      ),
    );
  }

}