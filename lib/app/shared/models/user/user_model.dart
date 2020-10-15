import 'dart:convert';

import 'package:fazentech/app/shared/models/user/address.dart';
import 'package:fazentech/app/shared/models/user/phone.dart';

class UserModel {
  String id;
  String photo;
  String name;
  String email;
  String cpf;
  String rg;
  String password;
  Phone phone;
  Phone cellphone;
  DateTime birthday;
  Address address;

  UserModel({
    this.id,
    this.photo,
    this.name,
    this.email,
    this.cpf,
    this.rg,
    this.password,
    this.phone,
    this.cellphone,
    this.birthday,
    this.address
  });
  
  UserModel copyWith({
    String id,
    String photo,
    String name,
    String email,
    String cpf,
    String rg,
    String password,
    Phone phone,
    Phone cellphone,
    DateTime birthday,
    Address address
  }) {
    return UserModel(
      id: id ?? this.id,
      photo: photo ?? this.photo,
      name: name ?? this.name,
      email: email ?? this.email,
      cpf: cpf ?? this.cpf,
      rg: rg ?? this.rg,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      cellphone: cellphone ?? this.cellphone,
      birthday: birthday ?? this.birthday,
      address: address ?? this.address
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'photo': photo,
      'name': name,
      'email': email,
      'cpf': cpf,
      'rg': rg,
      'password': password,
      'phone': phone?.toMap(),
      'cellphone': cellphone?.toMap(),
      'birthday': birthday?.toString(),
      'address': address?.toMap()
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return UserModel(
      id: map['id'],
      photo: map['photo'],
      name: map['name'],
      email: map['email'],
      cpf: map['cpf'],
      rg: map['rg'],
      password: map['password'],
      phone: Phone.fromMap(map['phone'] ?? {}),
      cellphone: Phone.fromMap(map['cellphone'] ?? {}),
      birthday: DateTime.tryParse(map['birthday'] ?? ''),
      address: Address.fromMap(map['address'] ?? '')
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => 
    UserModel.fromMap(
      source == null 
        ? null 
        : json.decode(source)
    );

  @override
  String toString() {
    return 'User(id: $id, photo: $photo, name: $name, email: $email, cpf: $cpf, rg: $rg, password: $password, phone: $phone, cellphone: $cellphone, birthday: $birthday, address: $address)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is UserModel &&
      o.id == id &&
      o.photo == photo &&
      o.name == name &&
      o.email == email &&
      o.cpf == cpf &&
      o.rg == rg &&
      o.password == password &&
      o.phone == phone &&
      o.cellphone == cellphone &&
      o.birthday == birthday &&
      o.address == address;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      photo.hashCode ^
      name.hashCode ^
      email.hashCode ^
      cpf.hashCode ^
      rg.hashCode ^
      password.hashCode ^
      phone.hashCode ^
      cellphone.hashCode ^
      birthday.hashCode ^
      address.hashCode;
  }
}
