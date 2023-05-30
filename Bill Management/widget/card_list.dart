import 'package:bill_management/models/cardList.dart';
import 'package:bill_management/models/card_local.dart';
import 'package:bill_management/screens/expense_screen.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import '../resorces/expenses_db.dart';
import '../bloc/card_provider.dart';




class CardListViewer extends StatelessWidget {
  BuildContext parentContext ;
  CardListViewer(this.parentContext) ;

 Widget build(Context){
    final bloc = CardProvider.of(Context) ;
    final Future<List<CardLocal>> cardListDb = dbAccess.fetchTableRows() ;
    final Future<int> budget = dbAccess.fetchMonthBudget() ;
    // print("hlo yhtrelengadv ${cardListDb.toString()}") ;

      return FutureBuilder(
        future: cardListDb ,
        builder: (context ,AsyncSnapshot<List<CardLocal>> futureSnapshot){
            if(futureSnapshot.hasData){
              // if(futureSnapshot.data == Null)
              // {
              //   return Text("fgddsggdfsfsd") ;
              // }
              int expense = 0 ;
              for (var i = 0; i < futureSnapshot.data!.length; i++) {
                expense = expense + futureSnapshot.data![i].totalExpense ;
              }


              // print("asfadf fsf asdf asfasdfdsa fasdf asf${futureSnapshot.data}");
              return SingleChildScrollView(
                
                child:   Column(
                children: [
                  totalExpense(expense , bloc),
                  leftAmount(context , expense, budget , bloc) ,
                  Card(
                    shadowColor: Colors.black,
                    margin: EdgeInsets.only(left: 10.0, right: 10.0 , top :8.0 , bottom: 8.0),
                    elevation: 5.0,
                    child: Container(
                      width: double.infinity,
                      height: 35.0,
                      padding: EdgeInsets.only(top: 5.0),
                      child:const Text(
                        "Different Expenses",
                        textScaleFactor: 1.5,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Serif",
                          color: Color.fromARGB(255, 10, 73, 124) ,
                        ),
                        ),
                    ),
                  ),

                
                  
                    listOfExpense(futureSnapshot.data) ,
                ],
              ) 
              ) ;

            }
            else{
              return const Center(
                child: CircularProgressIndicator(),
              ) ;
            }
        } ,
        );
  }

  Widget leftAmount( BuildContext context,  int expense ,Future<int> budget ,CardBlock bloc){
    return FutureBuilder(
      future: budget,
      builder: (context ,AsyncSnapshot<int> snapshot){
      if(!snapshot.hasData){
        return const Center(
          child: CircularProgressIndicator(),
        ) ;
      }

      int amount = snapshot.data! - expense;
      // print("amount: ${amount}") ;
      // print("expense: ${expense}");
      return Card(
      shadowColor: Colors.black,
      margin: EdgeInsets.only(left: 10.0 , right: 10.0 , top: 15.0),
      elevation: 5.0,
      child: Container(
        width: double.infinity,
        height: 80.0,
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.only(left: 20.0),
                width: 190.0,
                alignment: Alignment.centerLeft,
                child: Text(
                  "Left Amount :",
                  textScaleFactor: 2.0,
                style: TextStyle(
                  fontWeight: FontWeight.bold ,
                  color:(amount.isNegative)? Colors.black :Color.fromARGB(255, 25, 196, 25) ,
                  fontFamily: "Serif" ,
                  // fontSize: 30 ,
                  shadows:const [
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
              child: Text(
                      // (amount.isNegative)? "-${amount}":"${amount}",
                      "${amount}" ,
                      
                      textScaleFactor: 2.0,
                      style:TextStyle(
                        fontWeight: FontWeight.bold,
                        color:(amount.isNegative)? Colors.black :Color.fromARGB(255, 25, 196, 25) ,



                        fontFamily: "Serif",
                      ),
                    ),
              )


            

          ],
        ),
      ),

    ) ;


      }
      );
  }


  Widget totalExpense( int expense , CardBlock bloc){
    return Card(
      shadowColor: Colors.black,
      margin: EdgeInsets.only(left: 10.0 , right: 10.0 , top: 15.0),
      elevation: 5.0,
      child: Container(
        width: double.infinity,
        height: 80.0,
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.only(left: 20.0),
                width: 190.0,
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Your Expense :",
                  textScaleFactor: 2.0,
                style: TextStyle(
                  fontWeight: FontWeight.bold ,
                  color: Color.fromARGB(255, 156, 38, 30) ,
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
              child: Text(
                      expense.toString(),
                      textScaleFactor: 2.0,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 156, 38, 30) ,
                        fontFamily: "Serif",
                      ),
                    ),
              )


            

          ],
        ),
      ),

    ) ;
  }


  Widget listOfExpense(List<CardLocal>? cardList){
    // print(cardList) ;

    if(cardList!.isNotEmpty){
    return ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: cardList.length,
            itemBuilder: (context, index) {
              return Card(
                shadowColor: Colors.black,
                margin: EdgeInsets.only(left: 10.0 , right: 10.0 , bottom: 12.5),
                elevation: 5.0,
                child: SizedBox(
                  height: 130.0,
                  child: expenseCard(context , cardList[index]),
                )
                

              ) ;
          

              
              
            },


          ); 
    }
    else{
      return const  Center(
        child: SizedBox(
          height: 80.0,
          width: 250.0,
          child:Text("Add Expense To Get Started" , 
          textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.green , 
          fontSize: 30.0 , 
          fontWeight: FontWeight.bold,
          fontFamily: "Serif",
        ),
        ),
        )
        
      ) ;
    }
  }

  Widget expenseCard(BuildContext context , CardLocal card){
    // child(){
    //   if(card.amount != []){
    //       return Text("${card.amount.last.toString()}") ;

    //       }
    //       else{
    //       return Text("0") ;

    //       }
    // }
    late String lastExp ;
    late String time ; 

    (card.amount.length > 0)? lastExp= "Rs ${card.amount[card.amount.length - 1]}" : lastExp="" ;
    ( card.date.length >0)? time = card.date[card.date.length - 1] : time = "" ; 

    return ListTile(
      onTap: () {
        Navigator.of(parentContext).pushNamed("/${card.expenseType}")  ;
        // Navigator.push(context, MaterialPageRoute(builder: (context){return ExpenseScreen();})) ;
      },
      title: Container(
        padding: EdgeInsets.only(top: 8.0),
        child: Text(card.expenseType ,
                textScaleFactor: 1.15,
                style:const TextStyle(
                  color: Colors.red ,
                  fontSize: 25.0 ,
                  fontFamily: "Serif"
                ),
      
              ),
      ),
      subtitle: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child:  Row(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(right: 30.0),
            child: Text(lastExp ,
            style: const TextStyle(
              color: Color.fromARGB(255, 160, 88, 83) ,
              fontFamily: "Serif" ,
              fontSize: 25.0,
            ),
            ),
          ),
          Text(time,
          style: const TextStyle(
            color: Color.fromARGB(255, 97, 141, 177) ,
            fontFamily: "Serif",
            fontSize: 15.0,
          ),
          ) ,
          // Text("${card.date.last}") ,
        ],
      ),
      ),
      trailing: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 17.0),
            child: Text("Rs ${card.totalExpense}",
            // textScaleFactor: ,
            style: const TextStyle(
              color: Color.fromARGB(255, 163, 86, 80),
              fontFamily: "Serif" ,
              fontSize: 20,
            ),
            ),
          ),
          Container(
            // margin: EdgeInsets.only(bottom: 10.0 ),
            // alignment: Alignment.bottomCenter,
            child:const Text("Total Expense" ,
            style: TextStyle(
              color: Color.fromARGB(255, 163, 86, 80),
              fontFamily: "Serif",
              fontWeight: FontWeight.bold,
              fontSize: 12.5,
            ),
            ),
          ) ,
        

        ],
      ) 
      ) ;

  }


  
}