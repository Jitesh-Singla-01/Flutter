import 'package:flutter/material.dart';
import 'card_bloc.dart';
export 'card_bloc.dart';


class CardProvider extends InheritedWidget {
  final CardBlock bloc = CardBlock() ;


  CardProvider({ required Widget child})
          : super( child: child) ;

  bool updateShouldNotify(_) => true ;

  static CardBlock of(BuildContext context){
    return(context.dependOnInheritedWidgetOfExactType<CardProvider>() as CardProvider).bloc ;
  }


}