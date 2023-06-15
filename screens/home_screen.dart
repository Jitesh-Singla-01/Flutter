// import 'dart:fs

import 'dart:ffi';

import 'package:demo/bloc/card_provider.dart';
import 'package:demo/models/card_list.dart';
import 'package:demo/models/card_local.dart';
import 'package:demo/screens/home.dart';
import 'package:flutter/material.dart';
// import 'package:path/path.dart';
import "dart:math" ;
// import 'package:simple_animations/simple_animations.dart';


class HomeScreen extends StatelessWidget {
  final TextEditingController title = TextEditingController() ;
  final TextEditingController budget = TextEditingController() ;
  late int listIndex ; 
  late List<CardList> activeHeads ;
  late List<CardList> completedHead ;
  bool isShifted = false ;
  final List<String> _dropDownitems = ["Monthly Budget" , "Custom"] ;
  // final _date = "${DateTime.now().day}-${DateTime.now().month - 1}-${DateTime.now().year}" ;
  // final int _dateList = _date.split('-')

  // CardList pjk = CardList(totalBudget: 5220, expenseFor: "expenseFfgdffoghr", dateCreated: "10-05-2023" , budgetType: 0) ;
  

  int _dropDownValue = 0 ;
  bool activeShower = true ; 
  int prevSelec = -1 ;
  final List<Color> color = const [Color.fromARGB(255, 113, 44, 17),Color.fromARGB(255, 54, 14, 199),Color.fromARGB(255, 80, 7, 66)] ;
  // final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>() ;
  // final Animation _animation = Animation<Offset>() ;
  HomeScreen({super.key});



  @override
  Widget build(BuildContext context) {
    // print("1st page");
    final CardBlock bloc = CardProvider.of(context) ;   
    // bloc.addExpenseHead(pjk);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Different Expenses'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: bloc.expenseList,
        builder: (context, AsyncSnapshot<Future<List<CardList>>> snapshot) {
          if(!snapshot.hasData){
            bloc.getExpenseHead() ;
            return const Text("Still loading") ;
          }
          return FutureBuilder(
  
            future: snapshot.data,
            builder: (context, snapshot) {
              
              if(snapshot.hasData){

                return bodyMaker(context, snapshot , bloc) ;
              }
              return const Center(
                child: CircularProgressIndicator(),
                ) ;
            },
          ) ;
          
        },
      )
      
      
      ,
      floatingActionButton: FloatingActionButton(
        heroTag: Null,
        onPressed: (){
          
          addNewHead(context , bloc) ;          
        } ,
        child: const Icon(Icons.add),
      ),
    ) ;
  }


  Widget bodyMaker(context ,AsyncSnapshot<List<CardList>> snapshot , CardBlock bloc){
    if(snapshot.data!.isEmpty){
      
      return const Center (child : Text("Nothing Here Yet")) ;
       
    }
    else
    {
      activeHeads = <CardList> [];
      completedHead = <CardList> [] ;

      for(var card in snapshot.data!){
        if((card.isCompleted == 0) ){
          final int dayCrated = int.parse(card.dateCreated.split("-")[0]);
          final int monthCreated = int.parse(card.dateCreated.split("-")[1]);
          // final int yearCreated = int.parse(card.dateCreated.split("-")[2]);
          if((card.budgetType == 0) && (dayCrated <= DateTime.now().day) &&(monthCreated < DateTime.now().month)){
            card.isCompleted = 1;
            isShifted = true ;
            bloc.updateHead(card) ;

            completedHead.insert(0, card) ;
          }else{

            activeHeads.insert(0,card) ;
          }
        }
        else{
          completedHead.insert(0 ,card) ;
        }
      }
      listIndex = snapshot.data!.length -1 ;
      if(isShifted){
        shiftNotifier(context) ;
        isShifted =false ;
      }
      // return headDisplayer(activeHeads) ;
      if(activeShower){

        return Column(
          children: [
            headingDisplayer("Ongoing Expenses", activeShower, bloc) ,
            Expanded(child: headDisplayer(activeHeads)),
          ],
        ) ;
      }
      else{
        return Column(children: [
          headingDisplayer("Completed Expenses", activeShower, bloc) ,
          Expanded(child: headDisplayer(completedHead)),
          ]
        ) ;
        
      }

      

      
    }
  }

  shiftNotifier(context){
    return Future.delayed( Duration(microseconds: 0),()=> showDialog(context: context,
     builder: (context){
      
      return AlertDialog(
        content: const Text("Some Cards Has Been Closed Because a Month has passed since they were created .\nYou Can Review Them In Completed Expenses Section" ,
        textAlign: TextAlign.center,        
        style: TextStyle(
          color: Colors.green,
          fontSize: 20.0,
        ),),
        actions: [
          FloatingActionButton(onPressed: (){
            Navigator.pop(context);
          Navigator.pop(context);
           } ,
          child: const Text("DONE"),)
        ],
      ) ;
     }
     ));
     
     
  }

  Widget headingDisplayer(String heading , bool dir , CardBlock bloc){
    return Card(
            shadowColor: Colors.black,
            margin: EdgeInsets.only(left: 10.0, right: 10.0 , top :8.0 , bottom: 8.0),
            elevation: 5.0,
            child: Container(
              width: double.infinity,
              height: 45.0,
              padding: EdgeInsets.only(top: 5.0),
              child:Stack(
                children:[
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                    heading,
                    textScaleFactor: 1.5,
                    textAlign: TextAlign.center,
                    style:const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Serif",
                      color: Color.fromARGB(255, 10, 73, 124) ,
                    ),
                    ),
                  ),
                  Align(
                    alignment: (dir) ?Alignment.centerRight : Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(3.5),
                      child: FloatingActionButton.small(
                        onPressed: (){
                          if(activeShower){
                            activeShower=false ;
                          }else{
                            activeShower =true ;
                          }
                          bloc.getExpenseHead() ;
                        },
                        child: (dir)? Icon(Icons.arrow_forward_ios_outlined) : Icon(Icons.arrow_back_ios_outlined),
                        ),
                    ),
                  )
                  ]
              ),
            ),
          );
  }

  Widget headDisplayer(List<CardList> lst){
    return ListView.builder(
        shrinkWrap: true,
        primary: false,
      
        itemCount: lst.length,
        itemBuilder: (context , index ) {
         
          CardList expenseHead = lst[index] ;
          return  Card(
                  
                shadowColor: Colors.black,
                margin: const EdgeInsets.only(left: 10.0 , right: 10.0 , bottom: 12.5 , top: 7.5),
                elevation: 5.0,
                child: SizedBox(
                  height: 110.0,
                  child: expenseDisplayer(context , expenseHead ,listIndex),
                )
                      
              ) ;
            },
            
          ) ;
  }

  expenseDisplayer(context ,CardList expenseHead , int ind ){
    final CardBlock bloc = CardProvider.of(context) ;
    int selector = Random().nextInt(3) ;
    late int selec ;
    
    while(prevSelec == selector){
      selector = Random().nextInt(3) ;
    }
    prevSelec = selector ;
    // print(expenseHead) ;
    // int selec = if((selector +2) > 3) ?? selector%3   : selector ;
    if(selector+2 >=3){
      selec = selector-1 ;
    }
    else{
      selec =selector ;
    }
    
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color[selector] ,
              color[selec],
              Colors.transparent
            ]
            )
        ), 
      
        child : ListTile(
                title: GestureDetector(
                  onTap: () {
                    //Navigate to the screen with the whole expense Head //To Do 
                    newScreen(context ,bloc , expenseHead) ;
                    
                  },
                  child: Container(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Hero(
                            tag: "${expenseHead.expenseFor}title",
                            child: Material(
                              color: Colors.transparent,
                              child: Text(expenseHead.expenseFor ,
                                        textScaleFactor: 1.15,
                                        style: const TextStyle(
                                          // color: color[selector] ,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25.0 ,
                                          fontFamily: "Serif"
                                        ),
                                                      
                                    ),
                            ),
                            )

                        ),
                ),
                subtitle: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ) ,
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(bottom: 15.0 , right: 30.0),
                      child: Hero(
                        tag: "${expenseHead.expenseFor}bdg",
                        child: Material(
                          color: Colors.transparent,
                          child: Text("Budget Allocated : ${expenseHead.totalBudget}", 
                          style: const TextStyle(
                          color: Colors.white ,
                          fontFamily: "Serif" ,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold ,
                                              ),
                                              ),
                        )
                      
                      ),
                    ),
                  ],
                ) ,
                trailing: FloatingActionButton(
                  child: Icon(Icons.delete),
                  onPressed: () {
                    //To do Delete the whole card 
                    bloc.deleteExpenseHead(expenseHead.expenseFor) ;
                  
                  },
                  heroTag: "${expenseHead.expenseFor}btn$ind",
                ),
              ) ,
    ) ;
  }


  newScreen(context , CardBlock bloc , CardList expenseHead){
    //Navigate to the desired Screen
    

    // Navigator.push(context, MaterialPageRoute(
    //   // fullscreenDialog: true,
    //   builder: ((context) => Home(expenseHead)))) ;
     Navigator.push(context, transitionPage(expenseHead)) ;

  }

  Route transitionPage(CardList expenseHead) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Home(expenseHead) ;          
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // var tween = Tween<Offset>(begin: const Offset(-1, 0), end : Offset.zero) ;

        
        // return SlideTransition(
        //   position: animation.drive(tween),
        //   child: child,
        //   ) ;

        return Align(alignment: Alignment.center ,
          child: ScaleTransition(scale: animation ,child: child,));
      },

      
    ) ;
  }



  addNewHead(context , CardBlock bloc){
    //Add New Head 
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
                  Text("Expense For") ,
                  TextFormField(
                        controller: title,
                        textAlign: TextAlign.center,

                        style: const TextStyle(
                          // color: Colors.red ,
                          fontSize: 25.0 , 
                          fontWeight: FontWeight.bold,                   
                        ),
                      ) ,

                  ],
              ) 
            ) ,
            const SizedBox(
              height: 5.0,
            ) ,
            Container(
              height: 80.0,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text("Budget Allocated") ,
                  TextFormField(
                        controller: budget,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          // color: Colors.red ,
                          fontWeight: FontWeight.bold,                   
                          fontSize: 25.0 ,                    
                        ),
                      ) ,

                  ],
              ) 
            ) ,
            const SizedBox(
              height: 5.0,
            ) ,
            Container(
              height: 80.0,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text("Budget Type") ,
                  StatefulBuilder(

                    builder: (context , setState){
                      
                      return DropdownButton<String>(
                                items: _dropDownitems.map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                value: _dropDownitems[_dropDownValue],
                                onChanged: (String? value){
                                  if(value == _dropDownitems[0]){
                                    _dropDownValue = 0 ;
                                  }else{
                                    _dropDownValue =1 ;
                                  }
                                  setState((){}) ;
                                },
                                
                                style: const TextStyle(
                                  color: Colors.blue ,
                                  // fontWeight: FontWeight.bold,                   
                                  fontSize: 20.0 ,                    
                                ),
                              ) ;
                    } 
                    
                  ) ,

                  ],
              ) 
            ) 


          ],
        ),

        actions: [
          TextButton(onPressed: ()=>Navigator.pop(context),
           child: Text("cancel")) ,

          TextButton(onPressed: (){
            final expensefor = title.text.toUpperCase() ;
            final budgt = int.parse(budget.text) ;
            // final date = DateTime.now();
            final dt = "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}" ;
            final miscellenious = CardLocal("MISCELLENIOUS") ;
            final head = CardList(totalBudget: budgt, expenseFor: expensefor ,dateCreated: dt, expenseCards: [miscellenious] , budgetType: _dropDownValue);
            // _listKey.currentState!.insertItem(index)  ;
            bloc.addExpenseHead(head) ;
            title.text = "" ;
            budget.text = "";

            Navigator.pop(context) ;
            
          },
           child: const Text("Add")) ,
        ],
      ) ;
     }
    ) ;

  }
 
}