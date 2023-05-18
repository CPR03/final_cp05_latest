import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
//with this import it will allow the function to access the application directory

//this class will save the inputs in a file
class WantsFile {
  static List<Map<String, Object>> _wants = [];

  //this will read and load the saved file from application document directory
  static Future<List<Map<String, Object>>> loadWants() async {

    //this will read and load the saved file from application document directory
    //set to future which could contain future values
    final directory = await getApplicationDocumentsDirectory();

    //It will find the file from the directory in a json format named "wants.json"
    final file = File('${directory.path}/wants.json');

    //Check if the file exist in the directory
    if (await file.exists()) {
      final contents = await file.readAsString(); //read expenses.json file as a string

      final List<dynamic> json = jsonDecode(contents); //decode the json file to Dart Objects and assign to variable json for list mapping

      _wants = json.map<Map<String, Object>>((e) => Map<String, Object>.from(e)).toList(); //add the values to _expense List Map
      //e is the representation of json variable and turns ths variable to a list map and to list

    }
    return _wants; //return a located and decoded json file to a readable list mapv
  }

  // thhis code will save the file in a directory which cannot be access.
  //The application itself can only access this application document directory
  static Future<void> saveWants() async {
    final directory = await getApplicationDocumentsDirectory(); //Assign directory
    final file = File('${directory.path}/wants.json'); //Assign file name and where directory to save
    final json = jsonEncode(_wants); //Encode it to JSON file
    await file.writeAsString(json); //Write the data
  }

  //this will add new inputs to the _wants list above
  static void addWants(String title, double amount, DateTime date) {

    _wants.add({
      'title': title,
      'amount': amount,
      'date': date,
    });
    saveWants(); //save the values
  }

  //this will return the list from the _wants (get for retrieving value for private classes)
  //or we created a get wants to access the private class _wants
  static List<Map<String, Object>> get wants => _wants;
}
