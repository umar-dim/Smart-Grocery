class Item {
  final int? _ingredient_id;
  final String? _name;

  final int? _cost;
  late int? totalAvail;
  late final bool? _onSale;

  Item(this._cost, this._onSale, this._ingredient_id, this._name);

  int? get cost => _cost;

  int? get ingredientID => _ingredient_id;

  String? get name => _name;

  bool? get onSale => _onSale;
}
