import 'package:smart_grocery/food/item.dart';

class FoodBought {
  late final List<Item> _foodBought;

  int _cost = 0;
  FoodBought(this._foodBought) {
    for (var item in _foodBought) {
      _cost += item.cost!;
    }
  }

  List<Item> get foodBought => _foodBought;

  int get cont => _cost;
}
