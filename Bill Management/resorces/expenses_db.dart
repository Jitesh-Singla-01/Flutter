import 'dart:ffi';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import '../models/card_local.dart';
import '../models/cardList.dart';

class ExpensesDb {
  

  late String name ; 

  Future<Database> initializeDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory() ;
    final path = join(documentDirectory.path , "$name.db" ) ;
    return openDatabase(
      path,
      onCreate: (Database newDb , int version ) async{
        await newDb.execute(
          """CREATE TABLE expenses(expenseType TEXT  ,totalExpense INTEGER  ,amount TEXT  ,date TEXT)""" ,
        ) ;

        newDb.execute("""
              CREATE TABLE monthlyBudget(
              
                id INTEGER PRIMARY KEY ,
                budget INTEGER 
              )
          
          """,);
      },
      version: 1,
    );
  }

  Future<List<CardLocal>> fetchTableRows() async{
    final Database db = await initializeDb() ;
    final List<Map<String , dynamic>> maps = await db.query("expenses") ;
    return List.generate(maps.length, (i) {
      return CardLocal.fromDB(maps[i]) ;
    }) ;

  }

  Future<CardLocal> fetchItem(String par) async {
    final Database db = await initializeDb() ;

    final mapsList  = await db.query(
      "expenses" ,
      columns: null , 
      where: "expenseType = ?",
      whereArgs: [par] ,
    );

    
      return CardLocal.fromDB(mapsList.first) ;

  

  }

  Future<int> fetchMonthBudget () async {
    final Database db = await initializeDb() ;

    final List<Map<String , dynamic>> mapList = await db.query(
      "monthlyBudget" ,
      columns: null,
      where: "id =?" ,
      whereArgs: [0]
      ) ;
    
    if(mapList.length >0){
      return mapList.first["budget"] ;
    }
    return 0 ;
  }

  addItems(CardLocal card) async{
  
    final Database db = await initializeDb() ;


   await db.insert("expenses", card.toMap()) ;
    
  }

  addMonthBudget(int rs) async{
    final Database db = await initializeDb() ;

    Map<String , dynamic> map = {"id" : 0 , "budget" : rs} ; 
    await db.insert("monthlyBudget", map ) ;
  }

  updateItem(CardLocal card , String par) async{
    final Database db = await initializeDb() ;

    await db.update(
      "expenses" , 
      card.toMap() ,
      where: "expenseType = ?",
      whereArgs: [par]
      ) ;
    // print("object");
  }

  updateMonthBudget(int rs) async{
    Map<String , dynamic> map = {"id" : 0 , "budget" : rs} ; 
    final Database db = await initializeDb() ;

    await db.update(
      "monthlyBudget" , 
      map,
      where: "id = ?",
      whereArgs: [0] 
    ) ;
    // print("object") ;
  }

  delete(String par) async {
    final Database db = await initializeDb() ;

    await db.delete(
      "expenses" ,
      where: "expenseType = ?",
      whereArgs: [par]

    ) ;
  }



}

late ExpensesDb dbAccess = ExpensesDb()  ;