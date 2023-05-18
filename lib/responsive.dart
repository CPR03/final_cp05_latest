
import 'package:final_cp05/login.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyResponsive());
}

class MyResponsive extends StatefulWidget {
  const MyResponsive({super.key});

  @override
  State<MyResponsive> createState() => _MyResponsiveState();
}


class _MyResponsiveState extends State<MyResponsive> {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){

      if(constraints.maxWidth <= 480){
        return const MyLogin();
      }else{
        return Container();
      }

    });
  }


}