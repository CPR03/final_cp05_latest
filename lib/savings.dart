import 'package:final_cp05/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'addmoney.dart';
import 'main.dart';

class MySavings extends StatefulWidget {
  const MySavings({super.key});

  @override
  State<MySavings> createState() => MySavingsState();
}

class MySavingsState extends State<MySavings> {

  static double balanceSavings = 0.0; //savings variable
  final amountController = TextEditingController(); //will get values from the text field

  //function to deposit balance to savings
  void addDeposit(double amount){
    setState(() {
      balanceSavings += amount;
      AddMoneyState.balance -= amount;
      amountController.clear();

    });
  }

  //function to withdraw savings the back to balance
  void takeSavings (double amount){
    setState(() {
      balanceSavings -= amount;
      AddMoneyState.balance += amount;
      amountController.clear();

    });
  }

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

              //Row for back button and header
              child: Row(

                children: [

                  IconButton(onPressed: () {

                    //navigate back to home page, also to update the total
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => const MyHomePage())
                    );

                  }, icon: const Icon(Icons.arrow_back_ios_new_outlined, size: 30,)),

                  const Text("My Savings", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),

                ],
              ),

            ),

            //Main Container
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

                //Column for total, button, and text field
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [

                    //total savings text
                    Text("Total Savings Balance ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black.withOpacity(0.5)),),

                    const SizedBox(height: 20,),

                    //total savings
                    Text("₱ ${balanceSavings.toStringAsFixed(2)}", style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: mainFontColor),),

                    const SizedBox(height: 15,),

                    //Based interest which is not functional (design purpose only!)
                    Text("BASED INTEREST RATE ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black.withOpacity(0.5)),),

                    const SizedBox(height: 5,),

                    const Text("2.60% annually ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: mainFontColor),),

                    const SizedBox(height: 30,),

                    //Row for buttons
                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [

                        //Withdraw Button
                        InkWell(
                          onTap: () {

                            //function here

                            //for confirmation
                            showDialog(

                                context: context, builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                              ),


                              title: const Text("Are you sure you want to withdraw?"),

                              content:TextFormField(

                                controller: amountController,
                                keyboardType: const TextInputType.numberWithOptions(decimal: true), //Keyboard with numbers
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                decoration: InputDecoration(
                                    label: Text("Enter Amount",style: TextStyle(color: Colors.black.withOpacity(0.3), fontWeight: FontWeight.bold),),

                                    enabledBorder: const OutlineInputBorder(

                                        borderSide: BorderSide(
                                            width: 3,
                                            color: mainFontColor

                                        )
                                    )
                                ),
                              ),

                              actions: [

                                //this will close the alert dialog
                                TextButton(onPressed: () {

                                  Navigator.pop(context);

                                },
                                    child: const Text("No")),

                                //this will generate the function
                                TextButton(onPressed: () {

                                  //function here............
                                  final amount = double.tryParse(amountController.text);
                                  if (amount != null) {

                                    if (amount > balanceSavings) {

                                      showDialog(
                                          context: context,
                                          builder: (context)=>  AlertDialog(
                                            title: const Text("ERROR!"),
                                            content:  const Text("The entered amount exceeds your balance."),
                                            actions: [
                                              TextButton(
                                                onPressed: (){
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Ok"),
                                              )
                                            ],
                                          ));

                                    }else{

                                      takeSavings(amount);
                                      setState(() {});
                                      Navigator.pop(context);

                                    }
                                  }

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

                            child: const Center(child: Text("WITHDRAW", style: TextStyle(fontWeight: FontWeight.bold),)),

                          ),
                        ),

                        //Deposit Button
                        InkWell(

                          onTap: () {

                            //function here
                            showDialog(

                                context: context, builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                              ),


                              title: const Text("Are you sure you want to deposit?"),

                              content: TextFormField(

                                controller: amountController,
                                keyboardType: const TextInputType.numberWithOptions(decimal: true), //Keyboard with numbers
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                decoration: InputDecoration(
                                    label: Text("Enter Amount",style: TextStyle(color: Colors.black.withOpacity(0.3), fontWeight: FontWeight.bold),),

                                    enabledBorder: const OutlineInputBorder(

                                        borderSide: BorderSide(
                                            width: 3,
                                            color: mainFontColor

                                        )
                                    )
                                ),
                              ),


                              actions: [

                                //this will close the alert dialog
                                TextButton(onPressed: () {

                                  Navigator.pop(context);

                                },
                                    child: const Text("No")),

                                //this will generate the function
                                TextButton(onPressed: () {

                                  //function here............
                                  final amount = double.tryParse(amountController.text);
                                  if (amount != null && AddMoneyState.balance >= amount) {
                                    addDeposit(amount);
                                    setState(() {});
                                    Navigator.pop(context);

                                  }

                                  else {

                                    showDialog(context: context, builder: (context) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15)
                                      ),

                                      title: const Text("Not Enough Balance"),
                                      content: const Text ("You do not have enough balance to pay for this expense. Try to add more balance"),

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

                            child: const Center(child: Text("DEPOSIT", style: TextStyle(color: primary, fontWeight: FontWeight.bold),)),

                          ),
                        )

                      ],

                    )

                  ],
                ),
              ),
            ),

            const SizedBox(height: 15,),

            //Standard message
            Text("Save money, and be easy!", style: TextStyle(color: Colors.black.withOpacity(0.5)),)


          ],

        ),
      ),
    );

  }
}