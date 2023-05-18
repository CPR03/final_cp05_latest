import 'package:final_cp05/main.dart';
import 'package:final_cp05/theme/colors.dart';
import 'package:flutter/material.dart';

//Stateful Widget
class AddMoney extends StatefulWidget {
  const AddMoney({super.key});

  @override
  State<AddMoney> createState() => AddMoneyState();
}

//The State of the page
class AddMoneyState extends State<AddMoney> {

  static double balance = 0; //current balance
  final amountController = TextEditingController(); //will listen for every changes in the text-field and get those

  //function for adding balance
  void incrementBalance(){
    setState(() {
      balance += double.tryParse(amountController.text)!;
      amountController.clear(); //clear the controller for new updates

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: primary,

      body: SingleChildScrollView(
        child: Column(

          children: [

            //Header and back button
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 60),

              //Row for title page and back button
              child: Row(

                children: [

                  IconButton(onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => const MyHomePage())
                    );
                  }, icon: const Icon(Icons.arrow_back_ios_new_outlined, size: 30,)),

                  const Text("My Balance", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),

                ],
              ),

            ),

            //main total balance texts
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

                //Column for texts, text field, and button
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [

                    Text("Total Balance ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black.withOpacity(0.5)),),

                    const SizedBox(height: 20,),

                    Text("₱ $balance", style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: mainFontColor),),

                    const SizedBox(height: 15,),

                    Text("TYPE HOW MUCH TO ADD OR REMOVE", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.black.withOpacity(0.5)),),

                    const SizedBox(height: 10,),

                    //type field for adding/removing balance
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: TextFormField(
                        controller: amountController, //put every values or changes here
                        keyboardType: const TextInputType.numberWithOptions(decimal: true), //Keyboard with numbers

                        onChanged: (String enteredPayment) {

                          setState(() {});

                        },

                        //outline color
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
                    ),

                    const SizedBox(height: 20),

                    //add/remove to balance button
                    InkWell(
                      onTap: incrementBalance, //call the function to add/remove balance
                      //function here

                      child: Container(

                        width: 220,
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

                        child: const Center(child: Text("ADD / REMOVE TO BALANCE", style: TextStyle(color: primary, fontWeight: FontWeight.bold),)),

                      ),
                    )

                  ],
                ),
              ),
            ),

            const SizedBox(height: 15,),

            //Standard message
            Text("New Balance, Good Life.", style: TextStyle(color: Colors.black.withOpacity(0.5)),)


          ],

        ),
      ),
    );

  }
}

