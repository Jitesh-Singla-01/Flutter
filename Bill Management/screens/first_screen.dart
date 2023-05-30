

import 'package:bill_management/bloc/card_provider.dart';
import 'package:bill_management/models/card_local.dart';
import 'package:bill_management/myapp.dart';
import 'package:bill_management/resorces/expenses_db.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  // final Function() notifyParent ;
  // FirstScreen({required this.notifyParent});

  @override
  Widget build(BuildContext context){

    final bloc= CardProvider.of(context) ;
    
    return Scaffold(
      
      body: Container(
    
        decoration: const BoxDecoration(
          image:  DecorationImage(
            image : AssetImage('assets/assetImage.jpeg') ,
            fit: BoxFit.cover,

          )

        ),

        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Color.fromARGB(255, 81, 185, 233) ,
              ])
          ),

          child: Stack(
            children : [
              Container(
                padding: EdgeInsets.only(top: 50.0),

                child: const Align(
                  alignment: Alignment.topCenter,
                  child: Text("Start budgeting today!!" ,
                  textScaleFactor: 1.5,
                  style: TextStyle(
                    fontWeight: FontWeight.bold ,
                    color: Color.fromARGB(255, 25, 196, 25) ,
                    fontFamily: "Serif" ,
                    fontSize: 30 ,
                    shadows: [
                      BoxShadow(color: Colors.black,
                      blurRadius: 2.0,
                      spreadRadius: 2.0,
                      )
                    ]
                    // wordSpacing: .0,
                
                  ),
                  textAlign: TextAlign.center,
                    
                  ),

                ),
              ) ,
              
              
              
              
            Container(
            padding: EdgeInsets.only(bottom: 15.0),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                      onPressed: (){
                        onPressed(bloc , context) ;
                      }, 
                      style: ElevatedButton.styleFrom(
                       backgroundColor: const Color.fromARGB(255, 25, 196, 25) ,
                      ),
                      child: const Text("Get started" , 
                      textScaleFactor: 1.5,
                      style: TextStyle(
                        fontWeight: FontWeight.bold ,
                        color: Colors.white ,
                        shadows: [
                          BoxShadow(color: Colors.black,
                          blurRadius: 2.0,
                          spreadRadius: 2.0,
                        ),
                        ]
    

                      ),
                      ) , 
                     
                      ),
              ),

            
          ),
          ]



        ),
        )
      ),
    ) ;
  }

  void onPressed(CardBlock bloc , BuildContext context){
      
      final defaultCard = CardLocal("Necesseties");
      bloc.addExpenseTypes(defaultCard) ;
      dbAccess.addItems(defaultCard) ;
      dbAccess.addMonthBudget(0) ;
      // Navigator.push(context , MaterialPageRoute(builder: (context)=>MyApp()))  ;
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MyApp()), (route) => false);

      
      
    }
}