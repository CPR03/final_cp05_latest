import 'dart:convert';
import 'dart:io';

import 'package:final_cp05/functionn/expenseState.dart';
import 'package:path_provider/path_provider.dart';
//with this import it will allow the function to access the application directory

import 'expenseState.dart';
//with this import it will allow the function to access the application directory

//this class will save the inputs in a file to update the list everytime there is a change
class ExpensesFile {


  //List Map that will contain decoded json saved file values
  static List<Map<String, Object>> _expenses = [];

  //this will read and load the saved file from application document directory
  //set to future which could contain future values
  static Future<List<Map<String, Object>>> loadExpenses() async {

    //This will set the directory to load the file and access it
    final directory = await getApplicationDocumentsDirectory();

    //It will find the file from the directory in a json format named "expenses.json"
    final file = File('${directory.path}/expenses.json');

    //Check if the file exist in the directory
    if (await file.exists()) {

      //if exists
      final contents = await file.readAsString(); //read expenses.json file as a string
      final List<dynamic> json = jsonDecode(contents); //decode the json file to Dart Objects and assign to variable json for list mapping
      _expenses = json.map<Map<String, Object>>((e) => Map<String, Object>.from(e)).toList(); //add the values to _expense List Map
      //e is the representation of json variable and turns ths variable to a list map and to list

    }

    return _expenses; //return a located and decoded json file to a readable list map
  }

  // thhis code will save the file in a directory which cannot be access.
  //The application itself can only access this application document directory
  static Future<void> saveExpenses() async {

    final directory = await getApplicationDocumentsDirectory(); //Assign directory
    final file = File('${directory.path}/expenses.json'); //Assign file name and where directory to save
    final json = jsonEncode(_expenses); //Encode it to JSON file
    await file.writeAsString(json); //Write the data

  }

  //this List Map will add new inputs to the _expenses list above
  static void addExpense(String title, double amount, DateTime date) {

      _expenses.add({
        'title': title,
        'amount': amount,
        'date': date,
      });


      saveExpenses(); //save the values


  }

  //this will return the list from the _expenses (get for retrieving value for private classes)
  //or we created a get expenses to access the private class _expenses (ExpensesFile.expenses)
  static List<Map<String, Object>> get expenses => _expenses;
}
