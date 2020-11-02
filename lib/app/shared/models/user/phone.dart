import 'dart:convert';

class Phone {
  String id;
  String areaCode;
  String number;

  Phone({
    this.id,
    this.areaCode,
    this.number,
  });

  Phone copyWith({
    String id,
    String areaCode,
    String number,
  }) {
    return Phone(
      id: id ?? this.id,
      areaCode: areaCode ?? this.areaCode,
      number: number ?? this.number,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'area_code': areaCode,
      'number': number,
    };
  }

  factory Phone.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Phone(
      id: map['id'].toString(),
      areaCode: map['area_code'].toString(),
      number: map['number'].toString()
    );
  }

  String toJson() => json.encode(toMap());

  factory Phone.fromJson(String source) => 
    Phone.fromMap(
      source == null
        ? null
        : json.decode(source)
    );

  @override
  String toString() => 'Phone(id: $id, areaCode: $areaCode, number: $number)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Phone &&
      o.id == id &&
      o.areaCode == areaCode &&
      o.number == number;
  }

  @override
  int get hashCode => id.hashCode ^ areaCode.hashCode ^ number.hashCode;
}
