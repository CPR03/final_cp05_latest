

import 'package:final_cp05/theme/colors.dart';
import 'package:flutter/material.dart';

class MyDebts extends StatefulWidget {
  const MyDebts({super.key});

  @override
  State<MyDebts> createState() => _MyDebtsState();
}

class _MyDebtsState extends State<MyDebts> {

  //list of debts
  List<Map<String, dynamic>> _debts = [
    {'name': 'Test 1', 'price': 150},
    {'name': 'Test 2', 'price': 151},
    {'name': 'Test 3', 'price': 152},
  ];

  Map<String, dynamic>? _selectedOption;

  //String, dynamic to combine the two in the dropdown-button

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: primary,

      body: SingleChildScrollView(
        child: Column(

          children: [

            //back button

            //Header and back button
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 60),

              child: Row(

                children: [

                  IconButton(onPressed: () {
                    Navigator.pop(context);
                  }, icon: const Icon(Icons.arrow_back_ios_new_outlined, size: 30,)),

                  const Text("My Debts", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),

                ],
              ),

            ),

            //main graph here
            Container(

              width: 600,

              margin: const EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 10),

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


              child: Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 30),

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [

                    Text("Total Debts: ₱150", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black.withOpacity(0.5)),),

                    const SizedBox(height: 10,),

                    //items dropdown list here...........................................
                    Center(

                      child: DropdownButton <Map <String, dynamic>> (

                        value: _selectedOption,

                        //map _debts as e
                        items: _debts.map(
                                (e) => DropdownMenuItem <Map <String, dynamic>>(

                            value: e,
                                  child: Text('${e['name']} - ₱${e['price']}'),

                                )).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value;
                          });

                        },
                      )

                    ),

                    const SizedBox(height: 30,),

                    //buttons
                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [

                        //pay all button
                        InkWell(
                          onTap: () {

                            //function here

                            showDialog(

                                context: context, builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)
                              ),


                              title: const Text("Are you sure?"),
                              content: const Text ("Do you want to pay this debt?"),
                              actions: [

                                //this will close the alert dialog
                                TextButton(onPressed: () {

                                  Navigator.pop(context);

                                },
                                    child: const Text("No")),

                                //this will generate the function
                                TextButton(onPressed: () {

                                  //function here............

                                },
                                    child: const Text("Yes")),

                              ],
                            ));

                          },

                          child: Container(

                            width: 130,
                            height: 50,

                            decoration: BoxDecoration(
                                color: primary,
                                border: Border.all(
                                    color: mainFontColor,
                                    width: 3
                                ),

                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: grey.withOpacity(0.03),
                                    spreadRadius: 15,
                                    blurRadius: 5,

                                  ),
                                ]),

                            child: const Center(child: Text("PAY DEBT", style: TextStyle(fontWeight: FontWeight.bold),)),

                          ),
                        ),

                        InkWell(
                          onTap: () {

                            //function here

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

                            child: const Center(child: Text("ADD DEBTS", style: TextStyle(color: primary, fontWeight: FontWeight.bold),)),

                          ),
                        ),
                      ],
                    )

                  ],
                ),
              ),
            ),

            const SizedBox(height: 15,),

            //custom message
            Text("Debts. Debts. And Debts!", style: TextStyle(color: Colors.black.withOpacity(0.5)),)

          ],

        ),
      ),
    );

  }
}