
import 'dart:async';
import 'package:final_cp05/main.dart';
import 'package:final_cp05/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:final_cp05/functionn/wantssave.dart';
import 'package:final_cp05/functionn/wantState.dart';

import 'addmoney.dart';
import 'functionn/wantState.dart';


StreamController<double> streamController = StreamController<double>();

class MyWants extends StatefulWidget {
  const MyWants({super.key});

  @override
  State<MyWants> createState() => MyWantsState();
}

Map<String, dynamic>? _selectedOption;

class MyWantsState extends State<MyWants> {

  //List Map for expenses list which gets the values from a file
  final List<Map<String, Object>> _wants = WantsFile.wants; //gets the value to be displayed from a saved file (wantssave.dart)
  get wantsGet => _wants; //for accessing _wants variable where the saved file is at


  //save inputs in a file
  late bool isDuplicate;
  void _addWants(String title, double amount, DateTime date) {


    //Check if the want already exists
    bool isDuplicate = _wants.any((expense) =>
    expense['title'] == title &&
        expense['amount'] == amount &&
        expense['date'] == date);

    if (isDuplicate == false) {
      WantsFile.addWants(title, amount, date);
      NewWantsState.total += amount;
      setState(() {});
    }

  }

  //function to add NewWants to the list
  void _startAddNewWants(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewWants(_addWants),
        );
      },
    );
  }

  //Item list remover and updater
  void _removeWants(Map<String, dynamic> selectedOption) {

    var amount = selectedOption['amount'] as double; //get the amount value
    _wants.removeWhere((item) => item['title'] == selectedOption['title'] as String && item['amount'] == selectedOption['amount']);
    NewWantsState.total -= amount; //decrement the total wants
    AddMoneyState.balance -= amount; //decrement the total balances
    _selectedOption = null; //set the _selectedOption to null to prevent subtracting again
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    WantsFile.loadWants();
    return Scaffold(

      backgroundColor: primary,

      body: SingleChildScrollView(

        //stack is used to make the floating action button appear front of the containers
        child: Stack(
            children: [

              Column(

                children: [

                  //back button

                  //Header and back button
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 60),

                    child: Row(

                      children: [

                        IconButton(onPressed: () {

                          //navigate back to home page, also to update the total
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => const MyHomePage())
                            //used push to update the amount in the Home Page

                          );
                        }, icon: const Icon(Icons.arrow_back_ios_new_outlined, size: 30,)),

                        const Text("My Wants", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),

                      ],
                    ),

                  ),

                  //main graph here
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
                          const Text("Total Wants:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          Text("₱${NewWantsState.total}",style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40,color:green )),

                          const SizedBox(height: 10,),


                          //drop down wants selection
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

                                    //map _wants as e
                                    items: _wants.map(
                                            (e) => DropdownMenuItem <Map <String, dynamic>>(

                                          value: e,
                                          child: Text('${e['title']} - ₱${e['amount']}'),

                                        )).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedOption = value;
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
                                  content: const Text ("Do you want to pay this?"),
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
                                        _removeWants(_selectedOption!); //run function
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
                                          content: const Text ("You do not have enough balance to pay for this. Try to add more balance"),

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
                                  content: const Text ("Please select what to pay."),

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

                              child: const Center(child: Text("PAY WANT", style: TextStyle(color: primary, fontWeight: FontWeight.bold),)),

                            ),
                          ),
                        ],

                      ),
                    ),
                  ),


                  //PUT ADD wantS HERE
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

                    //PUT want LIST CODE HERE.......................................
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25, top: 25, bottom: 50),
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [


                          const Text("All Wants ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),

                          const SizedBox(height: 20,),

                          for (var want in _wants)
                            ListTile(
                              title: Text(want['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 21, color: mainFontColor),),
                              subtitle: Text(DateFormat.yMMMd().format(want['date'] as DateTime)),
                              trailing: Text('₱${(want['amount'] as double).toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                            ),

                        ],
                      ),
                    ),

                  ),

                  const SizedBox(height: 15,),

                  //Standard message
                  Text("Manage, Add, And Delete Your Wants!", style: TextStyle(color: Colors.black.withOpacity(0.5)),)

                ],
              ),

              //add button
              Positioned(
                bottom:50,
                right: 40,
                child: FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: ()=> _startAddNewWants(context),),),


            ]
        ),
      ),
    );

  }
}



