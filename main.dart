

// import 'package:bill_management/root_app.dart';
// import 'package:bill_management/screens/expense_screen.dart';
// import 'package:bill_management/screens/home.dart';
// import 'package:bill_management/start_app.dart';
// import 'package:demo/screens/home.dart';
import 'package:demo/screens/home_screen.dart';
import 'package:flutter/material.dart';
// import 'myapp.dart';
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
  
    Route routes (RouteSettings setting){
      if(setting.name == '/'){
        return MaterialPageRoute(
          builder: (context) {
            return HomeScreen() ;
          }
          ) ;
      }
      else{return MaterialPageRoute(
          builder: (context) {
            return HomeScreen() ;
          }
          ) ; }


    }

  runApp(CardProvider(child: MaterialApp(
    // onGenerateRoute: routes,
    home: HomeScreen(),
    )) ) ;


}


