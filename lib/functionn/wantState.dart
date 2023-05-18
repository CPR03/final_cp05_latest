
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme/colors.dart';

class NewWants extends StatefulWidget {
  final Function(String, double, DateTime) addWants;

  NewWants(this.addWants);

  @override
  NewWantsState createState() => NewWantsState();
}


class NewWantsState extends State<NewWants> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _sumController = TextEditingController();
  static double total = 0.0;
  DateTime? _selectedDate;

  void submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.tryParse(_amountController.text);

    //total += enteredAmount!;
    //_amountController.clear();

    _sumController.text = total.toString();

    if (enteredTitle.isEmpty || enteredAmount == null || _selectedDate == null) {
      return;
    }

    widget.addWants(enteredTitle, enteredAmount, _selectedDate!);

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