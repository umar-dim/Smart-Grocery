import 'package:smart_grocery/user/user.dart';

class Chef extends User{
  String? cuisine ;
  late bool? _subscriptions ;
  late int? _paymentInfo  ;

  Chef(String name , String email, this.cuisine ) {
    newUser() ;
    this.name = name ;
    this.email = email ;
    id = userCount ;
  }

  // Recipe recordRecipe () {
  //   return Recipe.empty() ;
  // }

  void postVideo () {
    return;
  }

  bool? get subscriptions => _subscriptions;

  set payment(int? value) {
    _paymentInfo = value;
  }

  set subscriptions(bool? value) {
    _subscriptions = value;
  }
}