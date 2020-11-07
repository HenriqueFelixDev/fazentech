import 'dart:convert';

class ParameterErrorModel {
  String value;
  String msg;
  String param;
  String location;

  ParameterErrorModel({
    this.value,
    this.msg,
    this.param,
    this.location,
  });

  ParameterErrorModel copyWith({
    String value,
    String msg,
    String param,
    String location,
  }) {
    return ParameterErrorModel(
      value: value ?? this.value,
      msg: msg ?? this.msg,
      param: param ?? this.param,
      location: location ?? this.location,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'msg': msg,
      'param': param,
      'location': location,
    };
  }

  factory ParameterErrorModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return ParameterErrorModel(
      value: map['value'],
      msg: map['msg'],
      param: map['param'],
      location: map['location'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ParameterErrorModel.fromJson(String source) => ParameterErrorModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ParameterErrorModel(value: $value, msg: $msg, param: $param, location: $location)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is ParameterErrorModel &&
      o.value == value &&
      o.msg == msg &&
      o.param == param &&
      o.location == location;
  }

  @override
  int get hashCode {
    return value.hashCode ^
      msg.hashCode ^
      param.hashCode ^
      location.hashCode;
  }
}
