import 'package:bill_management/bloc/card_provider.dart';
import 'package:bill_management/models/card_local.dart';
import 'package:flutter/material.dart';
import '../resorces/expenses_db.dart';

// class MajorExpenses extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return MajorExpensesState();
//   }
// }

class MajorExpenses extends StatelessWidget{
  late Future<int>  budget ;
  late TextEditingController budgetcontroller;

  // MajorExpensesState(){init();}
  // init() async{
  //     // bg =  await budget;

  // }

  // refresh(){
  //   setState(() {
      
  //   });
  // }
  
  


  Widget build(context){
    CardBlock  bloc = CardProvider.of(context) ;
    budget = dbAccess.fetchMonthBudget() ;
    return Card(
            shadowColor: Colors.black,
            margin: EdgeInsets.only(left: 10.0 , right: 10.0 , top: 15.0),
            elevation: 5.0,
            // surfaceTintColor: Colors.green,
            child: InkWell(
                    splashColor: Color.fromARGB(255, 142, 242, 145),
                    onTap:()=> changeBudget(context , bloc),
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
                                FutureBuilder(
                                  future: budget,
                                  builder:(context, AsyncSnapshot<int> snapshot) {
                                    if(snapshot.hasData){
                                      // print(snapshot.data);
                                      budgetcontroller = TextEditingController(text: "${snapshot.data}") ;
                                      return  Container(
                                                margin: EdgeInsets.only(right: 10.0),
                                                width: 140,
                                                alignment: Alignment.centerRight,
                                                child: Text(
                                                  "${snapshot.data}",
                                                  textScaleFactor: 2.0,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(255, 25, 196, 25) ,
                                                    fontFamily: "Serif",
                                                  ),
                                                ),
                                      );
                                    }
                                    else{
                                      return Container(
                                        margin: EdgeInsets.only(right: 10.0),
                                        width: 140,
                                        alignment: Alignment.centerRight,
                                        child: CircularProgressIndicator(),
                                      );
                                    }

                                  },
                                ) ,
                                

                              ],
                            ),
                  ) ,
            ),
        ) ;
  }

 changeBudget(BuildContext context , CardBlock bloc) async{
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
              onPressed: ()async{
                final int updatedBudget = int.parse(budgetcontroller.text) ;
                await dbAccess.updateMonthBudget(updatedBudget) ;
                // var j = await dbAccess.fetchMonthBudget() ;
                // print(j) ;
                // budget = Future(() => updatedBudget ); 
                // setState(() {
                  
                // }); 
                // budget = dbAccess.fetchMonthBudget();
                bloc.addExpenseTypes(null);
                // setState(() {
                  
                // });
                Navigator.pop(context) ;
              }, 
              child: const Text("Update") ,
              ),
          ],
        );
        

      } , 
      );
    
   

}


}



