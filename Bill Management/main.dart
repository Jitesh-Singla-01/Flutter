
// @dart=2.9
// import 'package:bill_management/root_app.dart';
// import 'package:bill_management/screens/expense_screen.dart';
// import 'package:bill_management/screens/home.dart';
// import 'package:bill_management/start_app.dart';
import 'package:flutter/material.dart';
import 'myapp.dart';
import 'bloc/card_provider.dart';

void main() {
  // runApp(MaterialApp(
  //   title : 'flutter Demo' ,
  //   theme : ThemeData(
  //     primarySwatch: Colors.blue ,
  //   ),
  //   routes: {
  //     "/" :(context) => CardProvider(child: Home()) ,
  //     "/Necesseties" :(context) => ExpenseScreen() 
  //   },
  //   // initialRoute: "/",
  //   // home :RootApp() ,
  // ));

  runApp(CardProvider(child: MyApp()) ) ;
}


