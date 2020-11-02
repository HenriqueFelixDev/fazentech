import 'dart:convert';

import 'address_state.dart';

class Address {
  String id;
  String street;
  String number;
  String city;
  AddressState state;
  String postalCode;
  String neighborhood;
  String complement;

  Address({
    this.id,
    this.street,
    this.number,
    this.city,
    this.state,
    this.postalCode,
    this.neighborhood,
    this.complement,
  });

  Address copyWith({
    String id,
    String street,
    String number,
    String city,
    AddressState state,
    String postalCode,
    String neighborhood,
    String complement,
  }) {
    return Address(
      id: id ?? this.id,
      street: street ?? this.street,
      number: number ?? this.number,
      city: city ?? this.city,
      state: state ?? this.state,
      postalCode: postalCode ?? this.postalCode,
      neighborhood: neighborhood ?? this.neighborhood,
      complement: complement ?? this.complement,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'street': street,
      'number': number,
      'city': city,
      'state': state?.name,
      'postal_code': postalCode,
      'neighborhood': neighborhood,
      'complement': complement,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Address(
      id: map['id'].toString(),
      street: map['street'],
      number: map['number'].toString(),
      city: map['city'],
      state: AddressState.valueOf(map['state'].toString().toLowerCase()),
      postalCode: map['postal_code'].toString(),
      neighborhood: map['neighborhood'],
      complement: map['complement'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) => 
    Address.fromMap(
      source == null
        ? null
        : json.decode(source)
    );

  @override
  String toString() {
    return 'Address(id: $id, street: $street, number: $number, city: $city, state: $state, postalCode: $postalCode, neighborhood: $neighborhood, complement: $complement)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Address &&
      o.id == id &&
      o.street == street &&
      o.number == number &&
      o.city == city &&
      o.state == state &&
      o.postalCode == postalCode &&
      o.neighborhood == neighborhood &&
      o.complement == complement;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      street.hashCode ^
      number.hashCode ^
      city.hashCode ^
      state.hashCode ^
      postalCode.hashCode ^
      neighborhood.hashCode ^
      complement.hashCode;
  }
}
