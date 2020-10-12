import 'dart:convert';

class Shipping {
  String type;
  double value;
  String postalCode;
  DateTime arrivalForecast;

  Shipping({
    this.type,
    this.value,
    this.postalCode,
    this.arrivalForecast,
  });

  Shipping copyWith({
    String type,
    double value,
    String postalCode,
    DateTime arrivalForecast,
  }) {
    return Shipping(
      type: type ?? this.type,
      value: value ?? this.value,
      postalCode: postalCode ?? this.postalCode,
      arrivalForecast: arrivalForecast ?? this.arrivalForecast,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'value': value,
      'postalCode': postalCode,
      'arrivalForecast': arrivalForecast?.toString(),
    };
  }

  factory Shipping.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Shipping(
      type: map['type'],
      value: map['value'],
      postalCode: map['postalCode'],
      arrivalForecast: DateTime.tryParse(map['arrivalForecast'] ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory Shipping.fromJson(String source) => 
    Shipping.fromMap(
      source == null
        ? null
        : json.decode(source)
    );

  @override
  String toString() {
    return 'Shipping(type: $type, value: $value, postalCode: $postalCode, arrivalForecast: $arrivalForecast)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Shipping &&
      o.type == type &&
      o.value == value &&
      o.postalCode == postalCode &&
      o.arrivalForecast == arrivalForecast;
  }

  @override
  int get hashCode {
    return type.hashCode ^
      value.hashCode ^
      postalCode.hashCode ^
      arrivalForecast.hashCode;
  }
}
