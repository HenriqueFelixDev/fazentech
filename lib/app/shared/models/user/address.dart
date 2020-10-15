import 'dart:convert';

import 'address_state.dart';

class Address {
  String id;
  String street;
  String number;
  String city;
  AddressState state;
  String postalCode;
  String district;
  String complement;

  Address({
    this.id,
    this.street,
    this.number,
    this.city,
    this.state,
    this.postalCode,
    this.district,
    this.complement,
  });

  Address copyWith({
    String id,
    String street,
    String number,
    String city,
    AddressState state,
    String postalCode,
    String district,
    String complement,
  }) {
    return Address(
      id: id ?? this.id,
      street: street ?? this.street,
      number: number ?? this.number,
      city: city ?? this.city,
      state: state ?? this.state,
      postalCode: postalCode ?? this.postalCode,
      district: district ?? this.district,
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
      'postalCode': postalCode,
      'district': district,
      'complement': complement,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Address(
      id: map['id'],
      street: map['street'],
      number: map['number'],
      city: map['city'],
      state: AddressState.valueOf(map['state']),
      postalCode: map['postalCode'],
      district: map['district'],
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
    return 'Address(id: $id, street: $street, number: $number, city: $city, state: $state, postalCode: $postalCode, district: $district, complement: $complement)';
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
      o.district == district &&
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
      district.hashCode ^
      complement.hashCode;
  }
}
