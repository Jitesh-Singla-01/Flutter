import 'package:demo/resorces/expense_db.dart';
import 'package:rxdart/rxdart.dart' ;
import '../models/card_local.dart';
import '../models/card_list.dart';

class CardBlock {
  final _expenseHeadList = PublishSubject <Future<List<CardList>>> () ;
  final _expenseTypes = PublishSubject <dynamic>() ;
  final _singleExpenseList = PublishSubject<CardLocal>() ;
//   final _expenseTypes = PublishSubject <CardLocal>() ;

//   final _particularExpense = PublishSubject<List<dynamic>>() ;


//   //getter to streams 
//  Observable<CardLocal> get expenseTypes => _expenseTypes.stream ;
//  Observable<dynamic> get particularExpense => _particularExpense.stream; 



//  Function get addExpenseTypes => _expenseTypes.sink.add ;
//  Function get addParticularExpense => _particularExpense.sink.add ;

//getter to stream 
get expenseList => _expenseHeadList.stream ;
get expenseTypes => _expenseTypes.stream ;
get singleExpense => _singleExpenseList.stream ;

// Add to the expense type ....
Function get addExpenseType => _expenseTypes.add ;
Function get addSingleExpense =>_singleExpenseList.add ;



 getExpenseHead() {
  _expenseHeadList.add(dbAccess.fetchTableRows()) ;
 }

 addExpenseHead(CardList newExpense) async{
  await dbAccess.addItems(newExpense) ;
  getExpenseHead() ;
 } 

 deleteExpenseHead(String expenseFor) async{
  await dbAccess.delete(expenseFor) ;
  getExpenseHead() ;  
 }

 updateHead(CardList newHead){
  dbAccess.updateItem(newHead, newHead.expenseFor);
  addExpenseType(newHead.expenseCards) ;
  // getExpenseHead();

 }

 updateExpenseType (CardList newHead , int index){
  updateHead(newHead);
  addSingleExpense(newHead.expenseCards[index]) ;
 }






  dispose() {
    _expenseTypes.close() ;
    // _particularExpense.close() ;
    _expenseHeadList.close() ;
    _singleExpenseList.close() ;
   
    
  }

}