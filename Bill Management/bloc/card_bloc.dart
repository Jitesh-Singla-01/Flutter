import 'package:rxdart/rxdart.dart' ;
import '../models/card_local.dart';
import '../models/cardList.dart';

class CardBlock {
  final _expenseTypes = PublishSubject <CardLocal>() ;

  final _particularExpense = PublishSubject<List<dynamic>>() ;
  // final _singleExpense = PublishSubject<List<CardLocal>>() ;

  //getter to streams 
 Observable<CardLocal> get expenseTypes => _expenseTypes.stream ;
 Observable<dynamic> get particularExpense => _particularExpense.stream; 
//  Observable<List<CardLocal>> get singleExpense => _singleExpense.stream ;


 Function get addExpenseTypes => _expenseTypes.sink.add ;
 Function get addParticularExpense => _particularExpense.sink.add ;
//  Function get addSingleExpense => _singleExpense.sink.add ;



  dispose() {
    _expenseTypes.close() ;
    _particularExpense.close() ;
    // _singleExpense.close() ;
  }

}