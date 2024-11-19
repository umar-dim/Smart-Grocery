class Store {
  String address;
  String zipcode;
  int? id;
  String location;
  String name;
  String image_path;

  // string has to match json
  Map<String, dynamic> toMap() {
    return {
      'Address': address,
      'Zip': zipcode,
      'Location': location,
      'store_id': id,
      'store_name': name,
      'image_path': image_path
    };
  }

  Store(
      {required this.name,
      required this.address,
      required this.zipcode,
      required this.location,
      this.id,
      required this.image_path});

  factory Store.fromMap(Map<String, dynamic> map) {
    return Store(
      name: map['store_name'],
      address: map['Address'],
      zipcode: map['Zip'],
      location: map['Location'],
      id: map['store_id'],
      image_path: map['image_path'],
    );
  }

  String toString() {
    return 'Store{Name: $name, '
        'address: $address, '
        'zipcode: $zipcode, '
        'location: $location, '
        'id: $id,'
        'image_path: $image_path}\n';
  }
}
