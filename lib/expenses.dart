
import 'dart:async';
import 'package:final_cp05/addmoney.dart';
import 'package:final_cp05/main.dart';
import 'package:final_cp05/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:final_cp05/functionn/expenseState.dart';
import 'addmoney.dart';
import 'functionn/expensessave.dart';

//StreamController<double> streamController = StreamController<double>();

//Stateful Widgetf
class MyExpenses extends StatefulWidget {
const MyExpenses({super.key});

@override
State<MyExpenses> createState() => MyExpensesState();
}

//The State of the widget
class MyExpensesState extends State<MyExpenses> {

  //List Map for expenses list which gets the values from a file

  final List<Map<String, Object>> _expenses = ExpensesFile.expenses; //gets the value to be displayed from a saved file (expensesave.dart)
  get expensesGet => _expenses; //for accessing _expenses variable where the saved file is at
  Map<String, dynamic>? _selectedOption; //Selected expense nullable variable

  //save inputs in a file
  late bool isDuplicate;
  void _addExpense(String title, double amount, DateTime date) {

    //Check if the expense already exists
    bool isDuplicate = _expenses.any((expense) =>
    expense['title'] == title &&
        expense['amount'] == amount &&
        expense['date'] == date);

    if(isDuplicate == false) {

      ExpensesFile.addExpense(title, amount, date); //add the inputted value to be saved as file
      NewExpenseState.total += amount;
      setState(() {}); //updates the UI widget

    }
  }

  //function to add NewExpense to the list
  void _startAddNewExpense(BuildContext context) {

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewExpense(_addExpense), //will call NewExpense
        );
      },
    );

  }

  //Item list remover and updater
  void _removeExpense(Map<String, dynamic> selectedOption) {

    var amount = selectedOption['amount'] as double; //get the amount value
    _expenses.removeWhere((item) => item['title'] == selectedOption['title'] as String && item['amount'] == selectedOption['amount']);
    NewExpenseState.total -= amount; //decrement the total expenses
    AddMoneyState.balance -= amount; //decrement the total balance
    _selectedOption = null; //set the _selectedOption to null to prevent subtracting again
    setState(() {}); //Update the UI

  }

  @override
  Widget build(BuildContext context) {
    ExpensesFile.loadExpenses();
    return Scaffold(

      backgroundColor: primary,

      body: SingleChildScrollView(

        //stack is used to make the floating action button appear front of the containers
        child: Stack(
          children: [


            //Main Column for all elements
          Column(

            children: [

              //back button

              //Header and back button
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 60),

                //Row for the back button and header
                child: Row(

                  children: [

                    IconButton(onPressed: () {

                      //navigate back to home page, also to update the total
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => const MyHomePage())
                        //used push to update the amount in the Home Page

                      );
                    }, icon: const Icon(Icons.arrow_back_ios_new_outlined, size: 30,)),

                    const Text("My expenses", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),

                  ],
                ),

              ),

              //Container for total expenses, dropdown, and pay button
              Container(

                width: 600,
                height: 250,

                margin: const EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 10),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                          color: grey.withOpacity(0.01),
                          spreadRadius: 15,
                          blurRadius: 5,

                          ),
                    ]),

                //Total, dropdown and button
                child: Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      const Text("Total Expenses:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      Text("₱${NewExpenseState.total}",style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40,color:green )),

                      const SizedBox(height: 10,),


                  //drop down expenses selection
                  SizedBox(
                    width: 250,
                    child: DecoratedBox(

                      decoration: BoxDecoration(

                          color: Colors.white,
                          border: Border.all(color: Colors.black38, width:2),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 10)
                          ]
                      ),

                      child: Center(

                            child: DropdownButton <Map <String, dynamic>> (


                              value: _selectedOption,

                              //map _expenses as e
                              items: _expenses.map(
                                      (e) => DropdownMenuItem <Map <String, dynamic>>(

                                    value: e,
                                    child: Text('${e['title']} - ₱${e['amount']}'), //what will be displayed in the dropdown

                                  )).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedOption = value; //set the selected value based on value variable for every changes
                                });

                              },
                            )

                        ),

                        ),
                  ),

                      const SizedBox(height: 20,),

                      //pay button
                      InkWell(
                        onTap: () {

                          //if there is selected in the dropbox
                          if (_selectedOption != null){
                            showDialog(

                                context: context, builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                              ),


                              title: const Text("Are you sure?"),
                              content: const Text ("Do you want to pay this expense?"),
                              actions: [

                                //this will close the alert dialog
                                TextButton(onPressed: () {

                                  Navigator.pop(context);

                                },
                                    child: const Text("No")),

                                //this will generate the function
                                TextButton(onPressed: () {

                                  //function here............
                                  if (_selectedOption != null && AddMoneyState.balance >= _selectedOption!["amount"]){
                                    _removeExpense(_selectedOption!); //run function
                                    setState(() {}); //update the UI
                                    Navigator.pop(context);
                                  }

                                  //if not enough balance
                                  else if (AddMoneyState.balance < _selectedOption!['amount']) {

                                    showDialog(context: context, builder: (context) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15)
                                      ),

                                      title: const Text("Not Enough Balance"),
                                      content: const Text ("You do not have enough balance to pay for this expense. Try to add more balance"),

                                      actions: [
                                        TextButton(
                                            onPressed: () {

                                              Navigator.push(
                                                  context, MaterialPageRoute(builder: (context) => const MyExpenses())

                                              );

                                            },
                                            child: const Text("Okay"))
                                      ],

                                    ));


                                  }


                                },
                                    child: const Text("Yes")),

                              ],
                            ));

                            //if there is no selected
                          }else {

                            showDialog(context: context, builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                              ),

                              title: const Text("No Selection"),
                              content: const Text ("Please select what expense to pay."),

                              actions: [
                                TextButton(
                                    onPressed: () {

                                      Navigator.pop(context);

                                    },
                                    child: const Text("Okay"))
                              ],

                            ));
                          }

                        },

                        child: Container(

                          width: 130,
                          height: 50,

                          decoration: BoxDecoration(
                              color: mainFontColor,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: grey.withOpacity(0.03),
                                  spreadRadius: 15,
                                  blurRadius: 5,

                                ),
                              ]),

                          child: const Center(child: Text("PAY EXPENSE", style: TextStyle(color: primary, fontWeight: FontWeight.bold),)),

                        ),
                      ),
                    ],

                  ),
                ),
              ),


              //PUT ADD EXPENSES HERE
              Container(

                width: 600,


                margin: const EdgeInsets.only(top: 10, left: 25, right: 25, bottom: 10),

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: grey.withOpacity(0.03),
                        spreadRadius: 15,
                        blurRadius: 5,

                      ),
                    ]),

                //PUT EXPENSE LIST CODE HERE.......................................
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, top: 25, bottom: 50),
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [


                      const Text("All Expenses ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),



                      const SizedBox(height: 20,),

                      //to display the list map _expenses in the container
                      for (var expense in _expenses)
                        ListTile(
                          title: Text(expense['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 21, color: mainFontColor),),
                          subtitle: Text(DateFormat.yMMMd().format(expense['date'] as DateTime)),
                          trailing: Text('₱${(expense['amount'] as double).toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                        ),

                    ],
                  ),
                ),

              ),

              const SizedBox(height: 15,),

              //Standard message
              Text("Track, Add, And Delete Expenses!", style: TextStyle(color: Colors.black.withOpacity(0.5)),)

      ],
          ),

            //add button
            Positioned(
                bottom: 50,
                right: 40,
                child: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: ()=> _startAddNewExpense(context),),),

          ]
        ),
      ),
    );

  }
}



