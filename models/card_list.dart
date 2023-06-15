
import 'package:demo/models/card_local.dart';
// import 'package:flutter/material.dart';
import 'dart:convert';

class CardList {
  late dynamic expenseCards ;
  late int totalBudget ;
  late String expenseFor ;
  int isCompleted = 0 ; 
  late int budgetType ; 
  late String dateCreated ;

  CardList({required this.totalBudget ,required this.expenseFor , expenseCards ,required this.dateCreated ,isCompleted , required this.budgetType}) : expenseCards =expenseCards??<CardLocal>[] ;

  CardList.fromDb(Map<String,dynamic> map){
    final parsedList = json.decode(map["expenseCards"].toString()) ;
    expenseCards = parsedList.map((i)=>CardLocal.fromDB(i)).toList();
    totalBudget = map["totalBudget"] ;
    expenseFor = map["expenseFor"] ;
    dateCreated = map["dateCreated"];
    isCompleted = map["isCompleted"] ;
    budgetType = map["budgetType"] ;
  } 
  
  Map<String , dynamic> toMap(){
    return <String , dynamic>{
      "expenseCards" : json.encode(expenseCards) ,
      "totalBudget" : totalBudget,
      "expenseFor" : expenseFor,
      "dateCreated" : dateCreated,
      "isCompleted" : isCompleted,
      "budgetType" : budgetType
    };
  } 

}