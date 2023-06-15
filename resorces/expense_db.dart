import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
// import '../models/card_local.dart';
import '../models/card_list.dart';

class ExpensesDb {
  

  // late String name ; 

  Future<Database> initializeDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory() ;
    final path = join(documentDirectory.path , "expense.db" ) ;
    return openDatabase(
      path,
      onCreate: (Database newDb , int version ) async{
        await newDb.execute(
          """CREATE TABLE expenses(expenseFor TEXT, totalBudget INTEGER , expenseCards TEXT,dateCreated TEXT ,isCompleted INTEGER ,budgetType INTEGER  )""" ,
        ) ;
      },
      version: 1,
    );
  }

  Future<List<CardList>> fetchTableRows() async{
    final Database db = await initializeDb() ;
    final List<Map<String , dynamic>> maps = await db.query("expenses") ;
    return List.generate(maps.length, (i) {
      return CardList.fromDb(maps[i]) ;
    }) ;
  }

  Future<CardList> fetchItem(String par) async {
    final Database db = await initializeDb() ;

    final mapsList  = await db.query(
      "expenses" ,
      columns: null , 
      where: "expenseFor = ?",
      whereArgs: [par] ,
    );

    
    return CardList.fromDb(mapsList.first) ;

  

  }



  addItems(CardList card) async{
  
    final Database db = await initializeDb() ;


   await db.insert("expenses", card.toMap()) ;
    
  }

  updateItem(CardList card , String par) async{
    final Database db = await initializeDb() ;

    await db.update(
      "expenses" , 
      card.toMap() ,
      where: "expenseFor = ?",
      whereArgs: [par]
      ) ;
    // print("object");
  }


  delete(String par) async {
    final Database db = await initializeDb() ;

    await db.delete(
      "expenses" ,
      where: "expenseFor = ?",
      whereArgs: [par]

    ) ;
  }



}

late ExpensesDb dbAccess = ExpensesDb()  ;