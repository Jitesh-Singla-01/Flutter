
import 'package:bill_management/models/card_local.dart';
import 'package:bill_management/resorces/expenses_db.dart';
import 'package:bill_management/screens/expense_screen.dart';
// import 'package:bill_management/start_app.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:bill_management/screens/home.dart';
import "package:flutter/material.dart" ;
import 'dart:io';
import 'screens/first_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'bloc/card_provider.dart';

class MyApp extends StatelessWidget {
  

  final cardprovider = GlobalKey() ;
  // late final String path =  path_pr(); 

  Future<bool> pathPr () async{
    Directory documentDirectory = await getApplicationDocumentsDirectory() ;
    final String path = join(documentDirectory.path , "expenses.db" ) ;
    final isDb = await databaseExists(path);
    return isDb ;
  }
  
  late Future<bool> isDb = pathPr() ;

    Widget build (context){
      final bloc = CardProvider.of(context) ;

      return StreamBuilder(
        stream: bloc.expenseTypes,
        builder: (context , snapshot){
          if(snapshot.hasData) {
            // if(dbAccess.fetchItem(snapshot.data!.expenseType)==null){
            //   // dbAccess.addItems(snapshot.data!) ;

            // }
            // else{
            //   dbAccess.updateItem(snapshot.data!, snapshot.data!.expenseType) ;
            // }

          }
          return FutureBuilder(
            future: isDb,
            builder: (context , snapshot){
              if(snapshot.hasData){
                if(snapshot.data == true){
                  return MaterialApp(
                    onGenerateRoute: routes,
                    initialRoute: '/',
                  ) ;
                }
                else{
                  return MaterialApp(
                    home:FirstScreen()  ,
                  ) ;
                }
              }
              else{
                return const Center(
                  child: CircularProgressIndicator(),
                ) ;
              }
            }
            ) ;
        }
        ) ;


        



      // return FutureBuilder(
      //   future: isDb,
      //   builder: (context , AsyncSnapshot<bool> snapshot){
      //     if(snapshot.hasData){
      //           if(snapshot.data == true){
      //              return StartApp();
 
      //           }
      //         else{
      //           return StreamBuilder(
      //             stream: bloc.expenseTypes,
      //             builder:(context, snapshot) {
      //               if(snapshot.hasData){
      //                 dbAccess.addItems(snapshot.data!.last);
      //                 return StartApp() ;

      //               }
      //               else{
      //                 return FirstScreen() ;

      //               }
      //             },
      //           );
      //         }
      //     }
      //     else{
      //       return Text("data") ;
      //     }
      //   },

      // ) ;


      
    }

    Route routes(RouteSettings settings){
      if(settings.name != '/'){
        final type = settings.name!.replaceFirst('/' ,'');
        return MaterialPageRoute(
          builder: (context) {
            return  ExpenseScreen(type)  ;
          }
          ) ;
      }
      return MaterialPageRoute(builder: (context){
        return Home() ;
      }) ;
    }
    // Widget appBuilder(){
      

    // }

    }






