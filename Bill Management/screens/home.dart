// import 'dart:js';

import 'package:bill_management/models/card_local.dart';
import 'package:bill_management/widget/card_list.dart';
import 'package:bill_management/widget/majorexpenses.dart';
import 'package:flutter/material.dart';
// import 'package:path/path.dart';
import '../bloc/card_provider.dart';
import '../resorces/expenses_db.dart';

class Home extends StatelessWidget{

  TextEditingController expenseType = TextEditingController() ;
  @override
  Widget build(context) {
    final bloc = CardProvider.of(context) ;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Budget And Expenses' ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          MajorExpenses() ,
          Flexible(child: CardListViewer( context  ))   ,
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>addExpenseType(context , bloc) ,
        child: Icon(Icons.add), 
        ),
    ) ;
    
  }


  addExpenseType(BuildContext pcontext , CardBlock bloc){
    // bool isON = false;
    return showDialog(
      context: pcontext, 
      builder: (BuildContext context){
        return  AlertDialog(
          title: const Text(
            "Add New Expense Type",
            textScaleFactor: 1.2,
            style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 156, 38, 30) ,
                  fontFamily: "Serif",
                    ),
            ),

          content: Container(
            height: 150.0,
            alignment: Alignment.center,
            child: TextFormField(
              // onChanged: (value) {
              //   if(value.isEmpty){
              //     isON = false;
              //   }
              //   else{
              //     isON = true ;
              //   }
              // },
              controller: expenseType,
              // initialValue: budgetcontroller.text,
              textAlign: TextAlign.center,
              // keyboardType: TextInputType.number,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "Serif" ,
                color: Color.fromARGB(255, 156, 38, 30) ,
                fontSize: 25.0 , 
              ),

            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context
            ), 
            child: const Text("Cancel") ,
            ) ,
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: expenseType, 
              builder: (context ,value , child){
                return TextButton(
                        onPressed: (value.text.isEmpty)? null :  (){
                          final data = expenseType.text ;
                          final expense = CardLocal(data) ;
                          dbAccess.addItems(expense) ;
                          bloc.addExpenseTypes(expense) ;
                          Navigator.pop(context) ;
                
                        },
              
                         child: const Text("Save") ,
                      )  ;
              }
              ) ,


            
              // onPressed: (){
              //   if(expenseType.text.isEmpty){
              //     null;
              //   }
              //   else{

              //   final data = expenseType.text ;
              //   final expense = CardLocal(data) ;
              //   dbAccess.addItems(expense) ;
              //   bloc.addExpenseTypes(expense) ;
              //   Navigator.pop(context) ;
              //   }
              // },

          ],

        );

      }
      );
  }

  // Widget addExtype(BuildContext context){
  //   late bool isOn ;
  //   if(expenseType.text.isEmpty){
  //     isOn = false ;
  //   }
  //   else{
  //     isOn = true ;
  //   }

  //   return TextButton(
  //     onPressed: (){

  //     }, 
  //     child: const Text("Save") ,
  //     ) ;
    
  // }
    

}