import 'dart:convert';

import 'package:fazentech/app/shared/models/user/phone.dart';

class User {
  String id;
  String name;
  String email;
  String cpf;
  String rg;
  String password;
  Phone phone;
  Phone cellphone;
  DateTime birthday;

  User({
    this.id,
    this.name,
    this.email,
    this.cpf,
    this.rg,
    this.password,
    this.phone,
    this.cellphone,
    this.birthday,
  });
  
  User copyWith({
    String id,
    String name,
    String email,
    String cpf,
    String rg,
    String password,
    Phone phone,
    Phone cellphone,
    DateTime birthday,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      cpf: cpf ?? this.cpf,
      rg: rg ?? this.rg,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      cellphone: cellphone ?? this.cellphone,
      birthday: birthday ?? this.birthday,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'cpf': cpf,
      'rg': rg,
      'password': password,
      'phone': phone?.toMap(),
      'cellphone': cellphone?.toMap(),
      'birthday': birthday?.toString(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      cpf: map['cpf'],
      rg: map['rg'],
      password: map['password'],
      phone: Phone.fromMap(map['phone'] ?? {}),
      cellphone: Phone.fromMap(map['cellphone'] ?? {}),
      birthday: DateTime.tryParse(map['birthday'] ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => 
    User.fromMap(
      source == null 
        ? null 
        : json.decode(source)
    );

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, cpf: $cpf, rg: $rg, password: $password, phone: $phone, cellphone: $cellphone, birthday: $birthday)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is User &&
      o.id == id &&
      o.name == name &&
      o.email == email &&
      o.cpf == cpf &&
      o.rg == rg &&
      o.password == password &&
      o.phone == phone &&
      o.cellphone == cellphone &&
      o.birthday == birthday;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      cpf.hashCode ^
      rg.hashCode ^
      password.hashCode ^
      phone.hashCode ^
      cellphone.hashCode ^
      birthday.hashCode;
  }
}
