// import 'dart:js';

import 'package:demo/models/card_list.dart';
import 'package:demo/models/card_local.dart';
import 'package:demo/widget/card_list.dart';
import 'package:demo/widget/majorexpenses.dart';
import 'package:flutter/material.dart';
// import 'package:path/path.dart';
import '../bloc/card_provider.dart';


class Home extends StatelessWidget{

  final CardList mainHead ;
  Home(this.mainHead) ;

  

  final TextEditingController expenseType = TextEditingController() ;
  @override
  Widget build(context) {
    // print("2nd page") ;

    final bloc = CardProvider.of(context) ;
    return Scaffold(
      
      appBar: AppBar(
        title:Hero(
            tag: "${mainHead.expenseFor}title",
            child: Material(color: Colors.transparent,
              child: Text(mainHead.expenseFor ,
              textAlign: TextAlign.center,
              style: const TextStyle(
                
                fontWeight: FontWeight.bold ,
                fontSize: 24 ,
                color: Colors.white,
              ),)),
          ),
          
          
        centerTitle: true,
        ),
      
      body: Column(
        children: [
          MajorExpenses(mainHead) ,
          Flexible(child: CardListViewer( context , mainHead  ))   ,
        ],
      ),
      floatingActionButton: (mainHead.isCompleted ==0) ? Container(
        alignment: Alignment.bottomRight,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
         (mainHead.budgetType ==1)?FloatingActionButton(
          heroTag: null,
            onPressed: (){
              completeExpense(context, bloc) ;
            },
            child: const Icon(Icons.done),
          ) : const Text("") , 
          const SizedBox(
            height: 15.0,
          ) ,
          FloatingActionButton(
          heroTag: "btn${mainHead.expenseFor}",
          onPressed: (){
            if(mainHead.isCompleted ==1 ){
              null;  
            }else{
              addExpenseType(context , bloc) ;
            }
            } ,
          child: Icon(Icons.add), 
          ),
        ],
      ),
      ) : const Text("")
      
      
      
      
      // Column(
      //   children: [
      //     (mainHead.isCompleted ==0) ? FloatingActionButton.small(
      //       onPressed: (){
      //         completeExpense(context, bloc) ;
      //       },
      //       child: Icon(IconData(0xe1f6, fontFamily: 'MaterialIcons')),
      //     ) : const Text("") ,
      //     ]
      // ),
    ) ;
    
  }

  completeExpense(context , CardBlock bloc){
    return showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          title: const Text("Budget purpose completed ?? wana close this card ?",
          style: TextStyle(
            color: Color.fromARGB(255, 26, 77, 28),
    
          ),
          textScaleFactor: 1.25,

          ),
          content: const SizedBox(
            height: 25.0,
          ),
          actions: [
            TextButton(onPressed: ()=> Navigator.pop(context),
             child: Text("Cancel")),
            TextButton(onPressed:() {
              
              mainHead.isCompleted =1;
              bloc.updateHead(mainHead) ;
              bloc.getExpenseHead() ;
              Navigator.pop(context) ;
              Navigator.pop(context) ;


              
              // MaterialPageRoute(builder: ((context) => ExpenseScreen(mainHead: mainHead  , card: card)))
            },
             child: Text("Confirm")),
          ],
        );
      }
      );

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
              controller: expenseType,

              textAlign: TextAlign.center,

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
                          final data = expenseType.text.toUpperCase() ;
                          final expense = CardLocal(data) ;
                          mainHead.expenseCards.insert(0 ,expense) ;
                          // print(mainHead.expenseCards) ;
                          bloc.addExpenseType(mainHead.expenseCards) ;
                          bloc.updateHead(mainHead) ;
                          expenseType.text = "" ;
                          Navigator.pop(context) ;
                
                        },
              
                         child: const Text("Save") ,
                      )  ;
              }
              ) ,


            
              
          ],

        );

      }
      );
  }  
}