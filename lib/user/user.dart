abstract class User{
  late int _id;
  late String _name ;
  late String? _email ;
  late int? _phone;

  static int _userCount = 0;

  set email(String? value) {
    _email = value;
  }

  set phone(int? value) {
    _phone = value;
  }

  set id(int value) {
    _id = value;
  }

  set name(String value) {
    _name = value;
  }

  void newUser(){
    _userCount++ ;
  }
  int get id => _id;
  String get name => _name;
  String? get email => _email;
  int? get phone => _phone;
  int get userCount => _userCount;

}