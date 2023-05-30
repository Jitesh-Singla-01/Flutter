import 'dart:async';
import 'package:intl/intl.dart';

import 'package:bill_management/bloc/card_provider.dart';
import 'package:bill_management/models/card_local.dart';
import 'package:bill_management/myapp.dart';
import 'package:bill_management/resorces/expenses_db.dart';
import 'package:bill_management/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class ExpenseScreen extends StatelessWidget {
  late final String type ;
  TextEditingController singleExp = TextEditingController() ;
  late Future<CardLocal> card ;
  ExpenseScreen(t) {
   type= t ;
  }
  Widget build (context){
    CardBlock bloc = CardProvider.of(context) ;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          type,
        ),
        centerTitle: true,
      ),
      body: createList(bloc),
      floatingActionButton: Container(
        alignment: Alignment.bottomRight,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed:()=> onDelete(context , bloc) ,
            child: Icon(Icons.delete),
            heroTag: null,
          ) , 
          SizedBox(
            height: 15.0,
          ) ,
          FloatingActionButton(
            onPressed:()=> onAdd(context , bloc) ,
            child: Icon(Icons.add),
            heroTag: null,
            )
        ],
      ),
      )
      

    );
  
  }


  Widget createList(CardBlock bloc){
    return StreamBuilder(
      stream: bloc.particularExpense,
      builder: (BuildContext context , stSnapshot){
        card = dbAccess.fetchItem(type) ;
        return FutureBuilder(
          future: card,
          builder: (context ,AsyncSnapshot<CardLocal> snapshot){
            if(snapshot.hasData)
            {
              // print(snapshot.data!.amount) ;

            
            if(snapshot.data!.amount.isNotEmpty){
            return ListView.builder(
              itemCount: (snapshot.data!.amount.length),
              itemBuilder: (context, index) {

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
                    height: 50.0 ,
                    child: ListTile(
                      onTap: (){
                        
                        deleteOneDialogue(snapshot.data! , index , bloc , context) ;
                      },
                      title:Text(
                        "Rs. ${snapshot.data!.amount[index]}" ,
                        style:const TextStyle(
                          fontSize: 25.0 ,
                          color: Color.fromARGB(255, 173, 53, 45) ,

                        ),
                        ) ,
                      trailing: Text(
                        snapshot.data!.date[index].toString(),
                        style: const TextStyle(
                          fontSize: 20.0 ,
                          color: Color.fromARGB(255, 93, 176, 244)
                        ),
                        ),
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
            return const Center(
              child: CircularProgressIndicator(),
            ) ;
          }
          }
          ) ;
      }
      );
  }
  
  

  onDelete(context , CardBlock bloc)async{
    final c = await card ;
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
              dbAccess.delete(type) ;
              bloc.addExpenseTypes(c) ;
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
              // Navigator.pop(context) ;
              // Navigator.replace(context, oldRoute: MaterialPageRoute(builder: (context)=>ExpenseScreen(type)), newRoute: MaterialPageRoute(builder: (context)=>MyApp())) ;
              // Navigator.popAndPushNamed(context, '/') ;
              // Navigator.pushReplacementNamed(context, '/') ;
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
             child: Text("Delete")),
          ],
        );
      }
      );
    
  }

  onAdd(context , CardBlock bloc) async{
    final c = await card ;
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
        content:Container(
          height: 80.0,
          alignment: Alignment.center,
          child: TextFormField(
                controller: singleExp,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  color: Colors.red ,
                  fontSize: 25.0 ,
                
                ),

                ) ,
        ) ,

        actions: [
          TextButton(onPressed: ()=>Navigator.pop(context),
           child: Text("cancel")) ,

          TextButton(onPressed: (){
            final am = int.parse(singleExp.text);
            // final len = c.amount.length ;
            final tex= c.totalExpense + am ;
            // final date =DateFormat('dd-mm-yyyy').format(DateTime.now()) ;
            final date = DateTime.now();
            final dt = "${date.day}-${date.month}-${date.year} " ;
            
            c.amount.add(am) ;
            c.date.add(dt) ;
            c.totalExpense = tex ;
            dbAccess.updateItem(c, type) ;
            
            bloc.addExpenseTypes(c) ;
            bloc.addParticularExpense(c.amount) ;
            Navigator.pop(context) ;
            
          },
           child: Text("Add")) ,
        ],
      ) ;
     }
     ) ;
  }



  deleteOneDialogue(CardLocal cardUp , int index , CardBlock bloc , BuildContext context){
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
                 deleteOne(cardUp , index , bloc , context);}, 
              child: Text("Delete") ,
            ) ,
          ],
        ) ;
      });

  }


  deleteOne(CardLocal cardUp , int index , CardBlock bloc , BuildContext context){
    cardUp.date.removeAt(index) ;
    int totalUp = cardUp.totalExpense -int.parse(cardUp.amount[index].toString());
    cardUp.amount.removeAt(index) ;
    CardLocal cardUpdated = CardLocal(type , amount: cardUp.amount , date: cardUp.date ,totalExpense: totalUp) ;
    dbAccess.updateItem(cardUpdated, type) ;
    bloc.addExpenseTypes(cardUpdated) ;
    bloc.addParticularExpense(cardUp.amount) ;
    Navigator.pop(context) ;
        
  }

  
}