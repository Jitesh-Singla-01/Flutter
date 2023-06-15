// import 'dart:async';
import 'package:demo/models/card_list.dart';
// import 'package:intl/intl.dart';

import 'package:demo/bloc/card_provider.dart';
import 'package:demo/models/card_local.dart';
// import 'package:demo/screens/home.dart';
import 'package:flutter/material.dart';
// import 'package:path/path.dart';

class ExpenseScreen extends StatelessWidget {
  late final int index =0 ;
  final TextEditingController singleExp = TextEditingController() ;
  final TextEditingController expDetail = TextEditingController() ;
  late final CardLocal card ;
  late final CardList mainHead ;
  ExpenseScreen({required this.card , required this.mainHead}) ;
  Widget build (context){
    CardBlock bloc = CardProvider.of(context) ;
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: "${card.expenseType}-${card.totalExpense}1",
          child: Material(
            color: Colors.transparent,
            child: Text(
              card.expenseType,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold
              ),

            ),
          ),
        ),
        centerTitle: true,
      ),
      body: createList(bloc),
      floatingActionButton: (mainHead.isCompleted == 0) ?Container(
        alignment: Alignment.bottomRight,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed:(){
              if(mainHead.isCompleted == 1){
                null ;
              }else{
                onDelete(context ,card , bloc);

              }
              } ,
            child: Icon(Icons.delete),
            heroTag: null,
          ) , 
          SizedBox(
            height: 15.0,
          ) ,
          FloatingActionButton(
            onPressed:(){
              if(mainHead.isCompleted == 1){
                null ;
              }else{
                
                onAdd(context ,card , bloc);
              }
              } ,
            child: Icon(Icons.add),
            heroTag: null,
            )
        ],
      ),
      ) : const Text("") ,
      

    );
  
  }


  Widget createList(CardBlock bloc){
    return StreamBuilder(
      stream: bloc.singleExpense,
      builder: (BuildContext context ,AsyncSnapshot snapshot){
        if(snapshot.hasData)
            {
              // print(snapshot.data!.amount) ;

            
            if(snapshot.data!.amount.isNotEmpty){
            return ListView.builder(
              itemCount: (snapshot.data!.amount.length),
              itemBuilder: (context, indexList) {

                // return GestureDetector(
                //   onTap: ()=>deleteOneDialogue(snapshot.data! , index , bloc , context) ,
                //   child: Card(
                //     shadowColor: Colors.black,
                //     margin: EdgeInsets.only(left: 10.0 , right: 10.0 , bottom: 12.5),
                //     elevation: 5.0,
                //     child: Row(
                //       children: [
                //         Text(snapshot.data!.amount[index].toString()) ,
                //         Text(snapshot.data!.date[index].toString()),
                //       ],
                //     ),
                //   ),
                // ) ;




                
                return Card(
                  shadowColor: Colors.black,
                  margin: EdgeInsets.only(left: 10.0 , right: 10.0 , top: 12.5),
                  elevation: 5.0,
                  child: SizedBox(
                    height: 80.0 ,
                    child: ListTile(
                      onTap: (){
                        if(mainHead.isCompleted == 1){
                          null ;
                        }else{
                          
                          deleteOneDialogue(snapshot.data! , indexList , bloc , context) ;
                        }
                        
                      },
                      title:Text(
                        "Rs. ${snapshot.data!.amount[indexList]}" ,
                        style:const TextStyle(
                          fontSize: 25.0 ,
                          color: Color.fromARGB(255, 173, 53, 45) ,

                        ),
                        ) ,
                      trailing: Text(
                        snapshot.data!.date[indexList].toString(),
                        style: const TextStyle(
                          fontSize: 20.0 ,
                          color: Color.fromARGB(255, 93, 176, 244)
                        ),
                        ),
                      subtitle: Container(
                        margin: const EdgeInsets.only(top: 10.0),
                        child: 
                  
                          Text(
                          snapshot.data!.expenseDetail[indexList].toString(),
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 20.0 ,
                            color: Color.fromARGB(255, 93, 176, 244) ,
                          ),
                        ),
                  
                      ) 
                    ) ,
                  )
                ) ;



                   
              }
            ) ;
              }
              else{
                return Container(
                    alignment: Alignment.center,
                    child: Text("nothing here yet !!"),
                  );
                }
              }
          else{
            bloc.addSingleExpense(card) ;
            return const Center(
              child: CircularProgressIndicator(),
            ) ;
          }
          }
    ) ;
      
  }
  
  

  onDelete(context ,CardLocal card , CardBlock bloc)async{
    // final c = card ;
    return showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          title: const Text("Sure you want to delete this card ?",
          style: TextStyle(
            color: Colors.red,
    
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
              mainHead.expenseCards.removeAt(index) ;
              bloc.updateHead(mainHead) ;
              
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
              // Navigator.pop(context) ;
              // Navigator.replace(context, oldRoute: MaterialPageRoute(builder: (context)=>ExpenseScreen(type)), newRoute: MaterialPageRoute(builder: (context)=>MyApp())) ;
              // Navigator.popAndPushNamed(context, '/') ;
              // Navigator.pushReplacementNamed(context, '/') ;
              // Navigator.popUntil(context, (route) { if(route == MaterialPageRoute(builder: ((context) => ExpenseScreen(mainHead: mainHead  , card: card))) ) {return true ;} else {return false ;}}) ;
              // Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              // MaterialPageRoute(builder: ((context) => Home(mainHead)))
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => Home(mainHead)))) ;
              // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context) => Home(mainHead))), (route) { if(route == MaterialPageRoute(builder: ((context) => Home(mainHead))) ) {return true ;} else {return false ;}}) ;
              Navigator.pop(context) ;
              Navigator.pop(context) ;


              
              // MaterialPageRoute(builder: ((context) => ExpenseScreen(mainHead: mainHead  , card: card)))
            },
             child: Text("Delete")),
          ],
        );
      }
      );
    
  }

  onAdd(context ,CardLocal card , CardBlock bloc) {
    final c = card ;
    return showDialog(context: context,
     builder: (context){
      return AlertDialog(
        title: const Text("Add New Expense",
        textScaleFactor: 1.35,
        style: TextStyle(
          color: Colors.red ,
          fontWeight: FontWeight.bold ,
        ),
        
        ),
        content:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 80.0,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text("Amount") ,
                  TextFormField(
                        controller: singleExp,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          color: Colors.red ,
                          fontSize: 25.0 ,                    
                        ),
                      ) ,

                  ],
              ) 
            ) ,
            const SizedBox(
              height: 10.0,
            ) ,
            Container(
              height: 80.0,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text("Expense Detail") ,
                  TextFormField(
                        controller: expDetail,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.red ,
                          fontSize: 25.0 ,                    
                        ),
                      ) ,

                  ],
              ) 
            ) 


          ],
        ),

        actions: [
          TextButton(onPressed: ()=>Navigator.pop(context),
           child: const Text("cancel")) ,

          TextButton(onPressed: (){
            final am = int.parse(singleExp.text);
            final detail = expDetail.text ;
            // final len = c.amount.length ;
            final tex= c.totalExpense + am ;
            // final date =DateFormat('dd-mm-yyyy').format(DateTime.now()) ;
            final date = DateTime.now();
            final dt = "${date.day}-${date.month}-${date.year}" ;
            
            c.amount.add(am) ;
            c.date.add(dt) ;
            c.expenseDetail.add(detail) ;
            c.totalExpense = tex ;
            mainHead.expenseCards[index] = c ;
            
            bloc.updateExpenseType(mainHead, index) ;
            expDetail.text = '' ;
            singleExp.text ='' ;
            Navigator.pop(context) ;
            
          },
           child: Text("Add")) ,
        ],
      ) ;
     }
     ) ;
  }



  deleteOneDialogue(CardLocal cardUp , int indx , CardBlock bloc , BuildContext context){
    return showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          title:const Text("Are you sure you want to delete it this expense",
          style: TextStyle(
            color: Colors.red ,
            // fontSize: 22.5 , 
            fontWeight: FontWeight.bold ,
           ),
           textScaleFactor: 1.2,
          ),
          content: SizedBox(height: 30.0),
          actions: [
            TextButton(
              onPressed: () {
                // print(index) ;
                 Navigator.pop(context);}, 
              child: Text("cancel")),
            TextButton(
              onPressed:(){
                 deleteOne(cardUp , indx , bloc , context);}, 
              child: Text("Delete") ,
            ) ,
          ],
        ) ;
      });

  }


  deleteOne(CardLocal cardUp , int indx , CardBlock bloc , BuildContext context){
    cardUp.date.removeAt(indx) ;
    int totalUp = cardUp.totalExpense -int.parse(cardUp.amount[indx].toString());
    cardUp.amount.removeAt(indx) ;
    cardUp.expenseDetail.removeAt(indx) ;
    cardUp.totalExpense = totalUp ;
    mainHead.expenseCards[index] = cardUp ;
    bloc.updateExpenseType(mainHead, index) ;
    Navigator.pop(context) ;
        
  }

  
}