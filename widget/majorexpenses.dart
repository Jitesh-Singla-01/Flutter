import 'package:demo/bloc/card_provider.dart';
import 'package:demo/models/card_list.dart';
import 'package:flutter/material.dart';




class MajorExpenses extends StatelessWidget{
  late final CardList mainHead ;
  late TextEditingController budgetcontroller;
  late int headBudget ;
 
  MajorExpenses(CardList mainhead) {
    mainHead = mainhead ;
    headBudget = mainHead.totalBudget ;
    budgetcontroller = TextEditingController(text: "$headBudget") ;
    
  } 

 
  Widget build(context){
    CardBlock  bloc = CardProvider.of(context) ;
    return Card(
            shadowColor: Colors.black,
            margin: EdgeInsets.only(left: 10.0 , right: 10.0 , top: 15.0),
            elevation: 5.0,
            // surfaceTintColor: Colors.green,
            child: StatefulBuilder(
              builder: (stateContext , setState){
                return InkWell(
                          splashColor: Color.fromARGB(255, 142, 242, 145),
                          onTap:() {
                            if(mainHead.isCompleted == 1){
                              null ;
                            }else{
                              changeBudget(context , bloc , setState) ;
                            }
                            },
                          child :Container(
                                    width: double.infinity,
                                    height: 80.0,
                                    // alignment: Alignment.topLeft,
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 20.0),
                                          width: 190.0,
                                          alignment: Alignment.centerLeft,
                                          child: const Text(
                                            "Your Budget :",
                                            textScaleFactor: 2.0,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold ,
                                            color: Color.fromARGB(255, 25, 196, 25) ,
                                            fontFamily: "Serif" ,
                                            // fontSize: 30 ,
                                            shadows: [
                                              BoxShadow(color: Colors.black,
                                              blurRadius: 2.0,
                                              spreadRadius: 2.0,
                                              )
                                            ]
                                            

                                          ),
                                          ),
                                          
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(right: 10.0),
                                          width: 140,
                                          alignment: Alignment.centerRight,
                                          child: Hero(
                                            tag: "${mainHead.expenseFor}bdg",
                                            child: Material(
                                              color: Colors.transparent,
                                              child: Text(
                                              "$headBudget",
                                              textScaleFactor: 2.0,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(255, 25, 196, 25) ,
                                                fontFamily: "Serif",
                                              ),
                                                                                      ),
                                            ),
                                          ),
                                        ) ,
                                        

                                      ],
                                    ),
                                 ) ,
                       );
              }
            ) 
            
            
        ) ;
  }

 changeBudget(BuildContext context , CardBlock bloc , Function setState) {
    // dbAccess.init() ;
    return showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Update Budget !!",
            textScaleFactor: 1.5,
            style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 25, 196, 25) ,
                      fontFamily: "Serif",
                    ),
            ),
          content: Container(
            height: 150.0,
            alignment: Alignment.center,
            child: TextFormField(
              controller: budgetcontroller,
              // initialValue: budgetcontroller.text,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "Serif" ,
                color: Color.fromARGB(255, 25, 196, 25) ,
                fontSize: 30.0 , 
              ),

            ),
          ),
          actions: [
            TextButton(
              onPressed: (){
                final int updatedBudget = int.parse(budgetcontroller.text) ;
                mainHead.totalBudget = updatedBudget ;
                bloc.updateHead(mainHead);
                bloc.getExpenseHead() ;
                Navigator.pop(context) ;
                setState((){
                  headBudget = updatedBudget ;
                  budgetcontroller = TextEditingController(text: "$updatedBudget") ;
                }) ;
              }, 
              child: const Text("Update") ,
              ),
          ],
        );
        

      } , 
      );
    
   

}


}



