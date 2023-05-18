
import 'package:final_cp05/main.dart';
import 'package:final_cp05/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyLogin());
}

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Container(

          width: 600,
          height: 900,

          decoration: BoxDecoration(
              image: DecorationImage(
                  image: const AssetImage("assets/man.jpg"),
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
                  fit: BoxFit.cover),

          gradient: LinearGradient(
            begin: FractionalOffset.bottomCenter,
            end: FractionalOffset.topCenter,

            colors: [
            Colors.black,
              Colors.black,
              Colors.black,
              Colors.grey.withOpacity(0.1),
          ],

          ),

         ),
          
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            
            children: [

              Padding(
                padding: const EdgeInsets.only(top: 350, left: 15,),
                  child: Image.asset('assets/thrifty_noBG.png', scale: 4,)),

              Padding(
                padding: const EdgeInsets.only(left: 20),
                  child: Text("Welcome to Thrifty Money.", style: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),textAlign: TextAlign.left,)),
              const Padding(
                padding:  EdgeInsets.only(left: 20, top: 10, right: 100),
                  child: Text("With us, we will help you manage your expenses, create savings, add balance and track all at once.", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),textAlign: TextAlign.justify,)),

        InkWell(

          onTap: (){
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const MyHomePage())
            );
          },

          child: Padding(
            padding: const EdgeInsets.only(top: 25),

            child: Center(

              child: Container(

                width: 200,
                height: 50,

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

                child: const Center(child: Text("LET'S START!", style: TextStyle(color: mainFontColor, fontSize: 18,fontWeight: FontWeight.bold),)),

              ),
            ),
          ),
        )


          ],
            
          ),

        ),
      ),


    );
  }

}
