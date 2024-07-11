class Address {
  int id;
  String street;
  String city;
  String state;
  String zipCode;

  Address({
    required this.id,
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'street': street,
      'city': city,
      'state': state,
      'zip_code': zipCode,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      id: map['id'],
      street: map['street'],
      city: map['city'],
      state: map['state'],
      zipCode: map['zip_code'],
    );
  }
}
