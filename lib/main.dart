
import 'package:final_cp05/functionn/expenseState.dart';
import 'package:final_cp05/functionn/wantState.dart';
import 'package:final_cp05/login.dart';
import 'package:final_cp05/responsive.dart';
import 'package:final_cp05/wants.dart';
import 'package:flutter/material.dart';
import 'package:final_cp05/theme/colors.dart';
import 'expenses.dart';
import 'package:final_cp05/savings.dart';
import 'addmoney.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter CP105',

      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyResponsive(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  //variables / functions here

  //List Map for getting all the total values at once
  final Map<String, double> dataMap = {
    'Total Balance' : AddMoneyState.balance,
    'Total Savings' : MySavingsState.balanceSavings,
    'Total Expenses' : NewExpenseState.total,
    'Total Wants' : NewWantsState.total,
  };

  //List map for colors in pie disc chart
  final List<Color> colorList = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.yellow,
  ];

  //List for chart chooser
  final  chart = [
    {'title': 'Pie Chart'},
    {'title': 'Bar Chart'},
  ];

  //A nullable list map mainly for selected chart
  Map<String, dynamic>? _selectedOptionChart;

  //main
  @override
  Widget build(BuildContext context) {

    //Scaffold
    return Scaffold(


      //background color of the whole page
      backgroundColor: primary,

      //SingleChildScrollView widget allows the home page to be scrollable vertically
      body: SingleChildScrollView(

        //main column for the home page
        child: Column(

          //a column to make my home page start at the left
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const SizedBox(height: 55,),

            //My home title
            Padding(padding:const  EdgeInsets.only(left: 20),
                child: Text("My Home", style: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)), )),


            //Column for the main space of my home page
            Column(

              children: [

                //container for the profile overview
                Container(

                    width: 600,
                    height: 350,

                    //margin or spacing around the container
                    margin: const EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 10),

                    //container decoration and shadowing
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

                    //This is the contents of the container
                    child: Center (

                        child: Padding(

                          //padding inside the container profile
                            padding: const EdgeInsets.only(
                                top: 20, bottom: 25, right: 20, left: 20),

                            child: Column(

                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [

                                //Profile name and Photo
                                Container(

                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,

                                        boxShadow: [
                                          BoxShadow(
                                            color: grey.withOpacity(0.4),
                                            spreadRadius: 15,
                                            blurRadius: 17,

                                          ),
                                        ]),

                                    child: const CircleAvatar(
                                      backgroundImage: AssetImage("assets/symon.jpg"),radius: 55,)),

                                const SizedBox(height: 15,),

                                //User name
                                Text("Symon Dural", style: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: mainFontColor)),),

                                const SizedBox(height: 5,),

                                //Another Column for total current balance, expenses, and savings
                                Column(

                                  children: [

                                    //row for balance and its icon button
                                    Row(

                                      mainAxisAlignment: MainAxisAlignment.center,

                                      children: [

                                        //total balance
                                        Text("₱${AddMoneyState.balance.toStringAsFixed(2)} ", style: const TextStyle(fontSize: 30, color: mainFontColor, fontWeight: FontWeight.w600),),

                                        //add balance icon button
                                        IconButton(
                                            onPressed: () {

                                              //alert dialog for confirmation
                                              showDialog(
                                                  context: context, builder: (context) => AlertDialog(

                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(15)
                                                ),

                                                title: const Text("Are you sure?"),
                                                content: const Text ("Do you want to add money?"),

                                                //Yes and No text button
                                                actions: [

                                                  //this will close the alert dialog
                                                  TextButton(onPressed: () {

                                                    Navigator.pop(context);

                                                  },
                                                      child: const Text("No")),

                                                  //this will generate the function
                                                  TextButton(onPressed: () {

                                                    //function here............
                                                    Navigator.push(
                                                        context, MaterialPageRoute(builder: (context) => const AddMoney())
                                                    );


                                                  },
                                                      child: const Text("Yes")),

                                                ],
                                              ));


                                            },
                                            icon: const Icon(Icons.add_circle, size: 30, color: mainFontColor,))
                                      ],
                                    ),

                                    //balance title at the bottom of total balance
                                    const Text("Balance", style: TextStyle(fontSize: 15, color: black, fontWeight: FontWeight.w600)),

                                  ],
                                ),

                                const SizedBox(height: 20,),

                                //Row for Expenses, Salary, and Savings
                                Row(

                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                  children: [

                                    //Expense total column
                                    Column(

                                      children: [

                                        //Expense total
                                        Text("₱${NewExpenseState.total.toStringAsFixed(2)}", style: const TextStyle(fontSize:20, color: mainFontColor, fontWeight: FontWeight.w600),),
                                        const Text("Expenses", style: TextStyle(fontSize: 15, color: black, fontWeight: FontWeight.w600)),

                                      ],
                                    ),

                                    //visual line for separation of the two
                                    Container(
                                      width: 1,
                                      height: 40,
                                      color: black.withOpacity(0.3),
                                    ),

                                    //Savings total column
                                    Column(

                                      children:  [

                                        //Total Savings
                                        Text("₱ ${MySavingsState.balanceSavings.toStringAsFixed(2)} ", style: const TextStyle(fontSize: 20, color: mainFontColor, fontWeight: FontWeight.w600),),
                                        const Text("Savings", style: TextStyle(fontSize: 15, color: black, fontWeight: FontWeight.w600)),

                                      ],
                                    )

                                  ],
                                ),

                              ],

                            )
                        )
                    )

                ),

                //My Overview Section
                Column(

                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [

                    SizedBox(height: 15,), //space size above

                    //My overview title
                    Text("My Overview", style: TextStyle(fontSize: 25, color: mainFontColor, fontWeight: FontWeight.w800),)

                  ],

                ),


                //Column for tiles overview and charts with SingleChildScrollView horizontally
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal, //set the scroll to horizontal

                  child: Row(

                    children: [
                      Column(

                        children: [

                          //Tile 1 (InkWell for making the container clickable)
                          InkWell(

                            //If tap then it will go to coresponding page
                            onTap: (){

                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => const MyExpenses())
                              );

                            },

                            //Container for tile 1
                            child: Container(

                              width: 370,
                              height: 90,

                              //padding for this 1 tile
                              margin: const EdgeInsets.only(top: 20, left: 20, right: 25, bottom: 20),

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

                                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),

                                //Whole row for the 1 tile overview
                                child: Row(

                                  children: [

                                    //Container for Icon
                                    Container(

                                      width: 50,
                                      height: 50,

                                      decoration: BoxDecoration(
                                          color: arrowbgColor,
                                          borderRadius: BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                              color: grey.withOpacity(0.03),
                                              spreadRadius: 15,
                                              blurRadius: 5,

                                            ),
                                          ]),

                                      child: const Icon(Icons.money_off),

                                    ),

                                    const SizedBox(width: 15,),

                                    //For title and description
                                    Expanded(
                                      //to fix the size and spacing

                                      //Column for the title and description
                                      child: Column(

                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,

                                        children: const [

                                          Text("Total Expenses", style: TextStyle(
                                              fontSize: 15,
                                              color: black,
                                              fontWeight: FontWeight.bold)),
                                          Text("Click for more info of expenses.", style: TextStyle(fontSize: 10),)

                                        ],
                                      ),
                                    ),

                                    //for total fee

                                    Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text("₱${NewExpenseState.total.toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),))

                                  ],
                                ),
                              ),

                            ),
                          ),

                          //Tile 2 (InkWell for making the container clickable)
                          InkWell(

                            //If tap then it will go to corresponding page
                            onTap: () {
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => const MySavings())
                              );
                            },

                            //Container for tile 2
                            child: Container(

                              width: 370,
                              height: 90,

                              //padding for this tile 2
                              margin: const EdgeInsets.only(top: 0, left: 20, right: 25, bottom: 20),

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

                                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),

                                //Whole row for the 1 tile overview
                                child: Row(

                                  children: [

                                    //Icon
                                    Container(

                                      width: 50,
                                      height: 50,

                                      decoration: BoxDecoration(
                                          color: arrowbgColor,
                                          borderRadius: BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                              color: grey.withOpacity(0.03),
                                              spreadRadius: 15,
                                              blurRadius: 5,

                                            ),
                                          ]),

                                      child: const Icon(Icons.check),

                                    ),

                                    const SizedBox(width: 15,),

                                    //For title and description
                                    Expanded(

                                      //to fix the size and spacing

                                      //Column for the title and description
                                      child: Column(

                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,

                                        children: const [

                                          Text("Total Savings", style: TextStyle(
                                              fontSize: 15,
                                              color: black,
                                              fontWeight: FontWeight.bold)),
                                          Text("Click for more info of savings.", style: TextStyle(fontSize: 10),)

                                        ],
                                      ),
                                    ),

                                    //for total fee

                                    Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text("₱ ${MySavingsState.balanceSavings.toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),))

                                  ],
                                ),
                              ),

                            ),
                          ),

                          //Tile 3 (InkWell for making the container clickable)
                          InkWell(

                            //If tap then it will go to corresponding page
                            onTap: (){

                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => const MyWants())
                              );

                            },
                            child: Container(

                              width: 370,
                              height: 90,

                              ////padding for this 1 tile 2
                              margin: const EdgeInsets.only(top: 0, left: 20, right: 25, bottom: 20),

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

                                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),

                                //Whole row for the 1 tile overview
                                child: Row(

                                  children: [

                                    //Icon
                                    Container(

                                      width: 50,
                                      height: 50,

                                      decoration: BoxDecoration(
                                          color: arrowbgColor,
                                          borderRadius: BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                              color: grey.withOpacity(0.03),
                                              spreadRadius: 15,
                                              blurRadius: 5,

                                            ),
                                          ]),

                                      child: const Icon(Icons.shopping_cart),

                                    ),

                                    const SizedBox(width: 15,),

                                    //For title and description
                                    Expanded(

                                      //to fix the size and spacing

                                      //Column for the title and description
                                      child: Column(

                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,

                                        children: const [

                                          Text("Wants", style: TextStyle(
                                              fontSize: 15,
                                              color: black,
                                              fontWeight: FontWeight.bold)),
                                          Text("Click for more info of your wants.", style: TextStyle(fontSize: 10),)

                                        ],
                                      ),
                                    ),

                                    //for total fee

                                    Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child:  Text("₱ ${NewWantsState.total.toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),))

                                  ],
                                ),
                              ),

                            ),
                          ),

                        ],
                      ),


                      //Column for My Chart.....................................
                      Column(

                        children: [

                          Container(

                            width: 370,
                            height: 300,

                            //padding for this 1 tile
                            margin: const EdgeInsets.only(top: 20, left: 30, right: 20, bottom: 20),

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

                            //Scrollable Chart (for the contents to fit)
                            child: SingleChildScrollView(
                              child: Padding(

                                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),

                                  //Whole column for the 1 tile overview
                                  child: Column(

                                    children: [

                                      const Text("My Chart", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

                                      const SizedBox(height: 10,),

                                      //SizeBox for dropdown
                                      SizedBox(
                                        width: 150,
                                        height: 45,

                                        child: DecoratedBox(

                                          decoration: BoxDecoration(

                                              color: Colors.white,
                                              border: Border.all(color: Colors.black38, width:2),
                                              borderRadius: BorderRadius.circular(10),
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                    color: Colors.grey.withOpacity(0.3),
                                                    blurRadius: 10)
                                              ]
                                          ),

                                          //Main DropDown Code Location
                                          child: Center(

                                              child: DropdownButton <Map <String, dynamic>> (

                                                  //set the value of the dropdown to this list map selector
                                                  value: _selectedOptionChart,

                                                  //map _chart (Pie or Bar Graph List) as e
                                                  items: chart.map(

                                                          (e) => DropdownMenuItem <Map <String, dynamic>>(

                                                        value: e,
                                                        child: Text('${e['title']}'), //this will appear in the dropdown

                                                      )).toList(),

                                                  //Set the selected value on the dropdown based on _selectedOptionChart
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedOptionChart = value;
                                                    });


                                                  })

                                          ),

                                        ),
                                      ),

                                      //Pie and Bar Chart (In a ternary condition)

                                      _selectedOptionChart?['title'] == 'Pie Chart' ?

                                      //If Pie chart is selected in the dropdown, display the pie chart
                                      SizedBox(width: 300,
                                        height: 300,

                                        child:  PieChart(

                                          //Use the dataMap (Total Values of all) List Map as basis for the pie to visualize
                                          dataMap: dataMap,
                                          chartLegendSpacing: 20,
                                          chartRadius: MediaQuery.of(context).size.width/2, //Size of the chart itself

                                          //chart type we used is disc or pie
                                          chartType: ChartType.disc,

                                          //use the ListMap of all total values as legends
                                          legendOptions: const LegendOptions(
                                              showLegendsInRow: true,
                                              legendPosition: LegendPosition.bottom,
                                              showLegends: true,
                                              legendTextStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),

                                          ),

                                          //Set the color corresponding for each legend's index
                                          colorList: colorList,
                                        ),
                                      ) :

                                      _selectedOptionChart?['title'] == 'Bar Chart' ?

                                      //If Pie chart is selected in the dropdown, display the bar chart
                                      SizedBox(

                                        width: 300,
                                        height: 180,

                                        child: charts.BarChart(
                                          [

                                            charts.Series(

                                              id: 'Overview', //Just an ID of the bar chart

                                              //Use the dataMap List Map again as basis
                                              data: dataMap.entries.toList(),
                                              domainFn: (entry, _) => entry.key,
                                              measureFn: (entry, _) => entry.value,

                                              //Set colors for each bar
                                              colorFn: (entry, _) {
                                                // Map each data item to a color
                                                if (entry.key == 'Total Balance') {
                                                  return charts.MaterialPalette.blue.shadeDefault;
                                                } else if (entry.key == 'Total Savings') {
                                                  return charts.MaterialPalette.red.shadeDefault;
                                                } else if (entry.key == 'Total Expenses') {
                                                  return charts.MaterialPalette.green.shadeDefault;
                                                } else {
                                                  return charts.MaterialPalette.yellow.shadeDefault;
                                                }
                                              },
                                            ),

                                          ],

                                          animate: true,
                                          vertical: false,
                                        ),
                                      )
                                          : const Text(""),

                                    ],

                                  )

                              ),
                            ),

                          ),


                        ],
                      ),


                    ],
                  ),
                )

              ],
            ),


          ],
        ),
      ),


    );
  }
}

