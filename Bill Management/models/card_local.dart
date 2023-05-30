// import 'dart:ffi';
import 'dart:convert';

class CardLocal {
  late String expenseType ;
  late int totalExpense  ;
  late dynamic amount  ;
  late dynamic date  ;

  CardLocal(this.expenseType , {this.totalExpense = 0 , amount , date }) : amount=amount??[] , date=date ??[] ;

  CardLocal.fromDB(Map<String,dynamic> map){
    expenseType = map["expenseType"] ;
    amount = json.decode(map["amount"].toString());
    date = json.decode(map["date"].toString()) ;
    totalExpense = map["totalExpense"];

  } 

  Map<String , dynamic> toMap(){
    return <String , dynamic>{
      "expenseType" : expenseType ,
      "totalExpense" : totalExpense ,
      "amount" : json.encode(amount)  ,
      "date" : json.encode(date) 
    };
  } 

  @override
  String toString() {
    // TODO: implement toString
    Map<String , dynamic> map = {
      "expenseType" : expenseType ,
      "totalExpense" : totalExpense ,
      "amount" : amount ,
      "date" : date
    };

    return map.toString() ;
  }

}





