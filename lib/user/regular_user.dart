import 'package:smart_grocery/user/user.dart';

class RegularUser extends User{
  late String location ;
  late String _paymentInfo ;
  late String _foodPreferences ;

  RegularUser(String name , String email, this.location ,  String foodPreferences) {
    newUser() ;
    this.name = name ;
    this.email = email ;
    _foodPreferences= foodPreferences ;
    id = userCount ;
  }

  RegularUser.guest() {
    newUser();
    name = 'Guest_$id';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'location': location,
      'foodPreferences': _foodPreferences,
      'paymentInfo': _paymentInfo
    };
  }


  static RegularUser fromMap(Map<String, dynamic> map) {
    return RegularUser(
        map['name'],
        map['email'],
        map['location'],
        map['foodPreferences']
    ) ..id = map['id']
      ..phone = map['phoneNumber']
      .._paymentInfo = map['paymentInfo'];
  }

  // Recipe selectRecipe () {
  //   return Recipe.empty() ;
  // }
  void postRecipe () {
    return;
  }
  List<String> completePurchase () {
    return <String>[] ;
  }

  String? get paymentInfo => _paymentInfo;
}