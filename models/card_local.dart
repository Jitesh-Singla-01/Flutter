// import 'dart:ffi';
import 'dart:convert';

class CardLocal {
  late String expenseType ;
  late int totalExpense  ;
  late dynamic amount  ;
  late dynamic expenseDetail ; 
  late dynamic date  ;

  CardLocal(this.expenseType , {this.totalExpense = 0 , amount , expenseDetail, date }) : amount=amount??[] , expenseDetail=expenseDetail??[], date=date ??[] ;

  CardLocal.fromDB(Map<String,dynamic> map){
    expenseType = map["expenseType"] ;
    amount = json.decode(map["amount"].toString());
    date = json.decode(map["date"].toString()) ;
    totalExpense = map["totalExpense"];
    expenseDetail = json.decode(map["expenseDetail"].toString());

  } 

  Map<String , dynamic> toJson(){
    return <String , dynamic>{
      "expenseType" : expenseType ,
      "totalExpense" : totalExpense ,
      "amount" : json.encode(amount)  ,
      "date" : json.encode(date) ,
      "expenseDetail" : json.encode(expenseDetail)
    };
  } 

  @override
  String toString() {
    // TODO: implement toString
    Map<String , dynamic> map = {
      "expenseType" : expenseType ,
      "totalExpense" : totalExpense ,
      "amount" : amount ,
      "date" : date , 
      "expenseDetail" : expenseDetail
    };

    return map.toString() ;
  }

}





